module Frontend exposing (..)

import Browser exposing (UrlRequest(..))
import Browser.Navigation as Nav
import Html
import Html.Attributes as Attr
import Lamdera
import Types exposing (..)
import Url
import Browser.Events exposing (onAnimationFrame)
import Time
import Task


type alias Model =
    FrontendModel



app =
    Lamdera.frontend
        { init = init
        , onUrlRequest = UrlClicked
        , onUrlChange = UrlChanged
        , update = update
        , updateFromBackend = updateFromBackend
        -- , subscriptions = \_ -> onAnimationFrame Tick
                , subscriptions = \_ -> Time.every (1000 / 60) Tick
        , view = view
        }


init : Url.Url -> Nav.Key -> ( Model, Cmd FrontendMsg )
init url key =
    ( { key = key
      , message = "Welcome to Lamdera! You're looking at the auto-generated base implementation. Check out src/Frontend.elm to start coding!"
      , mostRecentRoundTripTime = 0
      }
    , Cmd.none
    )


update : FrontendMsg -> Model -> ( Model, Cmd FrontendMsg )
update msg model =
    case msg of
        Tick currentTime ->
            (model, Lamdera.sendToBackend (Request currentTime))

        GotResponse requestTime currentTime ->
            ({model | mostRecentRoundTripTime = (Time.posixToMillis currentTime) - (Time.posixToMillis requestTime)}, Cmd.none)
        
        UrlClicked urlRequest ->
            case urlRequest of
                Internal url ->
                    ( model
                    , Nav.pushUrl model.key (Url.toString url)
                    )

                External url ->
                    ( model
                    , Nav.load url
                    )

        UrlChanged url ->
            ( model, Cmd.none )

        NoOpFrontendMsg ->
            ( model, Cmd.none )


updateFromBackend : ToFrontend -> Model -> ( Model, Cmd FrontendMsg )
updateFromBackend msg model =
    case msg of
        Response requestTime ->
            ( model, Task.perform (GotResponse requestTime) Time.now )


view : Model -> Browser.Document FrontendMsg
view model =
    { title = ""
    , body =
        [ Html.div [ Attr.style "text-align" "center", Attr.style "padding-top" "40px" ]
            [ Html.img [ Attr.src "https://lamdera.app/lamdera-logo-black.png", Attr.width 150 ] []
            , Html.div
                [ Attr.style "font-family" "sans-serif"
                , Attr.style "padding-top" "40px"
                ]
                [ Html.text (String.fromInt model.mostRecentRoundTripTime) ]
            ]
        ]
    }