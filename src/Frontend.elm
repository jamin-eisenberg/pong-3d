module Frontend exposing (..)

import Browser exposing (UrlRequest(..))
import Browser.Events exposing (onAnimationFrame)
import Browser.Navigation as Nav
import Html
import Html.Attributes as Attr
import Lamdera
import Types exposing (..)
import Url


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


subscriptions : Model -> Sub msg
subscriptions _ =
    Sub.none


init : Url.Url -> Nav.Key -> ( Model, Cmd FrontendMsg )
init url key =
    ( {}
    , Cmd.none
    )


update : FrontendMsg -> Model -> ( Model, Cmd FrontendMsg )
update msg model =
    case msg of
        NoOpFrontendMsg ->
            ( model, Cmd.none )


updateFromBackend : ToFrontend -> Model -> ( Model, Cmd FrontendMsg )
updateFromBackend msg model =
    case msg of
        NoOpToFrontend ->
            ( model, Cmd.none )


view : Model -> Browser.Document FrontendMsg
view model =
    { title = "3D Pong"
    , body =
        [ Html.div [] []
        ]
    }
