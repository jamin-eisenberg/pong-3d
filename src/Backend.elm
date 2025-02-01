module Backend exposing (..)

import Acceleration exposing (Acceleration)
import Angle
import Browser.Events exposing (onAnimationFrameDelta)
import Direction3d exposing (Direction3d)
import Duration
import Force
import Lamdera exposing (ClientId, SessionId, onConnect, onDisconnect, sendToFrontend)
import Length
import Mass
import Physics.Body as Body
import Physics.World as World
import Platform.Cmd as Cmd
import Point3d exposing (Point3d)
import Quantity exposing (Quantity)
import Sphere3d exposing (Sphere3d)
import Types exposing (..)


type alias Model =
    BackendModel


app =
    Lamdera.backend
        { init = init
        , update = update
        , updateFromFrontend = updateFromFrontend
        , subscriptions = subscriptions
        }


subscriptions : Model -> Sub BackendMsg
subscriptions _ =
    Sub.batch
        [ onConnect (\_ -> Connected)
        , onDisconnect (\_ -> Disconnected)
        , onAnimationFrameDelta BackendTick
        ]


init : ( Model, Cmd BackendMsg )
init =
    ( { world = initWorld
      , players = []
      }
    , Cmd.none
    )


initWorld =
    World.empty
        |> World.add
            (Body.sphere (Sphere3d.atOrigin (Length.meters 0.1)) Ball
                |> Body.withBehavior (Body.dynamic Mass.kilogram)
                |> (\ball -> Body.applyImpulse (Quantity.times Duration.second (Force.newtons 1)) (Direction3d.yz (Angle.degrees 170)) (Body.originPoint ball) ball)
            )


update : BackendMsg -> Model -> ( Model, Cmd BackendMsg )
update msg model =
    case msg of
        NoOpBackendMsg ->
            ( model, Cmd.none )

        Connected newPlayerClientId ->
            let
                newPlayerIndex =
                    List.length model.players
            in
            case playerIndexToSide newPlayerIndex of
                Nothing ->
                    ( model, sendToFrontend newPlayerClientId JoinRejected )

                Just playerSide ->
                    ( { model
                        | players =
                            List.append model.players
                                [ { side = playerSide, clientId = newPlayerClientId }
                                ]
                      }
                    , Cmd.none
                    )

        Disconnected droppedPlayerClientId ->
            ( { model | players = List.filter (\player -> player.clientId == droppedPlayerClientId) model.players }, Cmd.none )

        BackendTick msElapsed ->
            let
                updatedWorld =
                    World.simulate (Duration.milliseconds 16) model.world
            in
            ( { model | world = updatedWorld }
            , Cmd.batch (List.map (\player -> sendToFrontend player.clientId (WorldUpdate updatedWorld)) model.players)
            )


playerIndexToSide : Int -> Maybe Side
playerIndexToSide i =
    case i of
        0 ->
            Just FrontSide

        1 ->
            Just BackSide

        2 ->
            Just LeftSide

        3 ->
            Just RightSide

        4 ->
            Just TopSide

        5 ->
            Just BottomSide

        _ ->
            Nothing


updateFromFrontend : SessionId -> ClientId -> ToBackend -> Model -> ( Model, Cmd BackendMsg )
updateFromFrontend sessionId clientId msg model =
    case msg of
        NoOpToBackend ->
            ( model, Cmd.none )

        PlayerInput keys ->
            ( model, Cmd.none )
