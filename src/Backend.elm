module Backend exposing (..)

import Acceleration exposing (Acceleration)
import Angle
import Block3d
import Browser.Events exposing (onAnimationFrameDelta)
import Direction3d exposing (Direction3d)
import Duration
import Force
import Frame3d exposing (Frame3d)
import Frontend exposing (playerDirection2d)
import Lamdera exposing (ClientId, SessionId, onConnect, onDisconnect, sendToFrontend)
import Length
import Mass
import Physics.Body as Body
import Physics.Coordinates exposing (WorldCoordinates)
import Physics.World as World
import Platform.Cmd as Cmd
import Point3d exposing (Point3d, coordinates)
import Quantity exposing (Quantity, Unitless)
import Sphere3d exposing (Sphere3d)
import Types exposing (..)
import Vector3d exposing (Vector3d)


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

        -- , onAnimationFrameDelta BackendTick TODO reinstate once this is not running 24/7
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
        |> World.add initBall


initBall =
    Body.sphere (Sphere3d.atOrigin (Length.meters 0.1)) Ball
        |> Body.withBehavior (Body.dynamic Mass.kilogram)
        |> (\ball -> Body.applyImpulse (Quantity.times Duration.second (Force.newtons 1)) (Direction3d.yz (Angle.degrees 170)) (Body.originPoint ball) ball)



-- TODO duplicate rep of side? in player and Id


paddle side =
    Body.block
        (Block3d.centeredOn Frame3d.atOrigin ( Length.meters 0.5, Length.meters 0.5, Length.meters 0.05 ))
        (PlayerOn side)


directionToPoint : Direction3d coordinates -> Point3d Unitless coordinates
directionToPoint dir =
    dir
        |> Direction3d.toVector
        |> Vector3d.components
        |> (\( x, y, z ) -> Point3d.xyz x y z)


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
                                [ { side = playerSide, clientId = newPlayerClientId, movementDirection = Nothing }
                                ]
                        , world =
                            model.world
                                |> World.add
                                    (paddle playerSide
                                        |> Body.moveTo (Frame3d.originPoint (sideFrame playerSide))
                                    )
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


sideDirection : Side -> Direction3d WorldCoordinates
sideDirection side =
    case side of
        FrontSide ->
            Direction3d.positiveZ

        BackSide ->
            Direction3d.negativeZ

        LeftSide ->
            Direction3d.negativeX

        RightSide ->
            Direction3d.positiveX

        TopSide ->
            Direction3d.positiveY

        BottomSide ->
            Direction3d.negativeY


sideFrame side =
    Frame3d.atPoint (directionToPoint (sideDirection side))
        |> Frame3d.at (Quantity.rate Length.meter (Quantity.float 1))


updateFromFrontend : SessionId -> ClientId -> ToBackend -> Model -> ( Model, Cmd BackendMsg )
updateFromFrontend sessionId clientId msg model =
    case msg of
        NoOpToBackend ->
            ( model, Cmd.none )

        PlayerInput keys ->
            let
                maybePlayer =
                    List.filter (\p -> p.clientId == clientId) model.players
                        |> List.head
            in
            case maybePlayer of
                Nothing ->
                    ( model, Cmd.none )

                Just { side } ->
                    ( model, Cmd.none )



-- ( { model
--     | world =
--         World.update
--             (\body ->
--                 if Body.data body == PlayerOn side then
--                     Body.translateBy playerDirection2d
--                 else
--                     body
--             )
--             model.world
--   }
-- , Cmd.none
-- )
