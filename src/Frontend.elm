module Frontend exposing (..)

import Angle
import AssocSet exposing (Set)
import Block3d
import Browser exposing (UrlRequest(..))
import Browser.Dom
import Browser.Events exposing (onAnimationFrameDelta)
import Browser.Navigation as Nav
import Camera3d exposing (Camera3d)
import Color
import Direction2d exposing (Direction2d)
import Direction3d
import Frame3d
import Html
import Html.Attributes as Attr
import Json.Decode
import Lamdera
import Length exposing (Meters)
import LineSegment3d exposing (LineSegment3d)
import Physics.Body as Body
import Physics.Coordinates exposing (WorldCoordinates)
import Physics.World as World
import Pixels
import Platform.Cmd as Cmd
import Point3d
import Scene3d
import Scene3d.Material as Material
import Speed exposing (MetersPerSecond)
import Sphere3d
import Task
import Types exposing (..)
import Url
import Vector2d exposing (Vector2d)
import Viewpoint3d


type alias Model =
    FrontendModel


app =
    Lamdera.frontend
        { init = init
        , onUrlRequest = \_ -> NoOpFrontendMsg
        , onUrlChange = \_ -> NoOpFrontendMsg
        , update = update
        , updateFromBackend = updateFromBackend
        , subscriptions = subscriptions
        , view = view
        }


subscriptions : Model -> Sub FrontendMsg
subscriptions _ =
    Sub.batch
        [ Browser.Events.onAnimationFrameDelta FrontendTick
        , Browser.Events.onKeyDown (Json.Decode.map KeyDown keyDecoder)
        , Browser.Events.onKeyUp (Json.Decode.map KeyUp keyDecoder)
        , Browser.Events.onResize (\w h -> Resize { width = w, height = h })
        ]


init : Url.Url -> Nav.Key -> ( Model, Cmd FrontendMsg )
init _ _ =
    ( { keysPressed = AssocSet.empty
      , viewportSize = { width = Pixels.int 0, height = Pixels.int 0 }
      , world = World.empty
      }
    , Task.perform
        (\{ viewport } ->
            Resize { width = round viewport.width, height = round viewport.height }
        )
        Browser.Dom.getViewport
    )


update : FrontendMsg -> Model -> ( Model, Cmd FrontendMsg )
update msg model =
    case msg of
        NoOpFrontendMsg ->
            ( model, Cmd.none )

        KeyDown key ->
            let
                newKeysPressed =
                    AssocSet.insert key model.keysPressed
            in
            updateKeysIfChanged newKeysPressed model

        KeyUp key ->
            let
                newKeysPressed =
                    AssocSet.remove key model.keysPressed
            in
            updateKeysIfChanged newKeysPressed model

        FrontendTick _ ->
            ( model, Cmd.none )

        Resize { width, height } ->
            ( { model | viewportSize = { width = Pixels.pixels width, height = Pixels.pixels height } }, Cmd.none )


updateKeysIfChanged : Set Key -> Model -> ( Model, Cmd FrontendMsg )
updateKeysIfChanged newKeysPressed model =
    let
        newDirectionsPressed =
            newKeysPressed
                |> AssocSet.map keyToPlayerDirection
    in
    if AssocSet.eq newDirectionsPressed (AssocSet.map keyToPlayerDirection model.keysPressed) then
        ( model, Cmd.none )

    else
        ( { model | keysPressed = newKeysPressed }
        , newDirectionsPressed
            |> PlayerInput
            |> Lamdera.sendToBackend
        )


keysToDirection : Set Key -> Vector2d MetersPerSecond FrontendPlayerCoordinates
keysToDirection keys =
    keys
        |> AssocSet.map (keyToPlayerDirection >> playerDirection2d >> Direction2d.toVector)
        |> AssocSet.foldr Vector2d.plus Vector2d.zero
        |> Vector2d.normalize
        |> Vector2d.toUnitless
        |> (\{ x, y } -> Vector2d.metersPerSecond x y)


keyToInt : Key -> Int
keyToInt key =
    case key of
        K_Up ->
            0

        K_Right ->
            1

        K_Down ->
            2

        K_Left ->
            3

        K_W ->
            4

        K_A ->
            5

        K_S ->
            6

        K_D ->
            7


keyToPlayerDirection : Key -> PlayerMovementDirection
keyToPlayerDirection key =
    case key of
        K_Up ->
            Up

        K_W ->
            Up

        K_Right ->
            Right

        K_D ->
            Right

        K_Down ->
            Down

        K_S ->
            Down

        K_Left ->
            Left

        K_A ->
            Left


keyDecoder : Json.Decode.Decoder Key
keyDecoder =
    Json.Decode.field "key" Json.Decode.string
        |> Json.Decode.andThen
            (\string ->
                case string of
                    "ArrowLeft" ->
                        Json.Decode.succeed K_Left

                    "ArrowRight" ->
                        Json.Decode.succeed K_Right

                    "ArrowUp" ->
                        Json.Decode.succeed K_Up

                    "ArrowDown" ->
                        Json.Decode.succeed K_Down

                    "w" ->
                        Json.Decode.succeed K_W

                    "a" ->
                        Json.Decode.succeed K_A

                    "s" ->
                        Json.Decode.succeed K_S

                    "d" ->
                        Json.Decode.succeed K_D

                    _ ->
                        Json.Decode.fail ("Unrecognized key: " ++ string)
            )


playerDirection2d : PlayerMovementDirection -> Direction2d FrontendPlayerCoordinates
playerDirection2d dir =
    case dir of
        Up ->
            Direction2d.positiveY

        Right ->
            Direction2d.positiveX

        Down ->
            Direction2d.negativeY

        Left ->
            Direction2d.negativeX


updateFromBackend : ToFrontend -> Model -> ( Model, Cmd FrontendMsg )
updateFromBackend msg model =
    case msg of
        NoOpToFrontend ->
            ( model, Cmd.none )

        JoinRejected ->
            ( model, Cmd.none )

        -- TODO join rejected
        WorldUpdate world ->
            ( { model | world = world }, Cmd.none )


view : Model -> Browser.Document FrontendMsg
view model =
    { title = "3D Pong"
    , body =
        [ Html.div
            [ Attr.style "position" "absolute"
            , Attr.style "left" "0"
            , Attr.style "top" "0"
            ]
            [ Scene3d.sunny
                { upDirection = Direction3d.z
                , sunlightDirection = Direction3d.xyZ (Angle.degrees -15) (Angle.degrees -45)
                , shadows = True
                , camera = camera
                , dimensions = ( model.viewportSize.width, model.viewportSize.height )
                , background = Scene3d.backgroundColor Color.darkCharcoal
                , clipDepth = Length.meters 0.1
                , entities = boxFrame ++ List.map displayBody (World.bodies model.world)
                }
            ]
        ]
    }



-- TODO add dimensional info to Id


displayBody : Body.Body Id -> Scene3d.Entity WorldCoordinates
displayBody body =
    Scene3d.placeIn (Body.frame body) (Scene3d.sphere (Material.color Color.lightBlue) (Sphere3d.atOrigin (Length.meters 0.1)))


boxFrame : List (Scene3d.Entity coordinates)
boxFrame =
    let
        boxFrameLines =
            Block3d.centeredOn Frame3d.atOrigin ( Length.meters 2, Length.meters 2, Length.meters 2 )
                |> Block3d.edges
    in
    List.map
        (Scene3d.lineSegment (Material.color Color.white))
        boxFrameLines


ballSphere : Scene3d.Entity coordinates
ballSphere =
    Scene3d.sphere
        (Material.nonmetal { baseColor = Color.lightBlue, roughness = 0 })
        (Sphere3d.atPoint (Point3d.meters 0 0 0) (Length.meters 0.2))


camera : Camera3d Meters WorldCoordinates
camera =
    Camera3d.perspective
        { viewpoint =
            Viewpoint3d.lookAt
                { eyePoint = Point3d.meters 0 7 0
                , focalPoint = Point3d.origin
                , upDirection = Direction3d.positiveZ
                }
        , verticalFieldOfView = Angle.degrees 24
        }
