module Main exposing (main)

import Angle
import Browser
import Browser.Dom as Dom
import Browser.Events as Events
import Camera3d
import Direction3d
import Html
import Html.Attributes as Attributes exposing (width)
import Length
import Pixels
import Point3d
import Quantity
import Scene3d
import Task
import Viewpoint3d


type Msg
    = AnimationFrame Float -- delta time (ms)
    | Resize { width : Int, height : Int }


type alias Model =
    { ball : Ball
    , playerSide : Paddle
    , sides :
        { top : SideContents
        , right : SideContents
        , bottom : SideContents
        , left : SideContents
        , back : SideContents
        }
    , viewportSize :
        { width : Quantity.Quantity Float Pixels.Pixels
        , height : Quantity.Quantity Float Pixels.Pixels
        }
    }


type alias Ball =
    {}


type alias Paddle =
    {}


type SideContents
    = PlayerPaddle Paddle
    | Wall


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


init : () -> ( Model, Cmd Msg )
init _ =
    let
        model =
            { ball = {}
            , playerSide = {}
            , sides =
                { top = Wall
                , right = Wall
                , bottom = Wall
                , left = Wall
                , back = Wall
                }
            , viewportSize = { width = Pixels.pixels 0, height = Pixels.pixels 0 }
            }

        resizeToViewport =
            Task.perform
                (\{ viewport } -> Resize { width = round viewport.width, height = round viewport.height })
                Dom.getViewport
    in
    ( model, resizeToViewport )


camera : Camera3d.Camera3d Length.Meters coordinates
camera =
    Camera3d.perspective
        { viewpoint =
            Viewpoint3d.lookAt
                { eyePoint = Point3d.meters 3 4 2
                , focalPoint = Point3d.meters -0.5 -0.5 0
                , upDirection = Direction3d.positiveZ
                }
        , verticalFieldOfView = Angle.degrees 24
        }


view : Model -> Html.Html Msg
view model =
    Html.div
        [ Attributes.style "position" "absolute"
        , Attributes.style "left" "0"
        , Attributes.style "top" "0"
        ]
        [ Scene3d.sunny
            { upDirection = Direction3d.z
            , sunlightDirection = Direction3d.xyZ (Angle.degrees 135) (Angle.degrees -60)
            , shadows = True
            , camera = camera
            , dimensions =
                ( Pixels.int (round (Pixels.toFloat model.viewportSize.width))
                , Pixels.int (round (Pixels.toFloat model.viewportSize.height))
                )
            , background = Scene3d.transparentBackground
            , clipDepth = Length.meters 0.1
            , entities = []
            }
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        AnimationFrame dt ->
            ( model, Cmd.none )

        Resize { width, height } ->
            ( { model
                | viewportSize =
                    { width = Pixels.float (toFloat width)
                    , height = Pixels.float (toFloat height)
                    }
              }
            , Cmd.none
            )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.batch
        [ Events.onAnimationFrameDelta AnimationFrame
        , Events.onResize (\width height -> Resize { width = width, height = height })
        ]
