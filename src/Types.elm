module Types exposing (..)

import Browser exposing (UrlRequest)
import Browser.Navigation exposing (Key)
import Url exposing (Url)
import Time
import Lamdera exposing (ClientId)

type alias FrontendModel =
    { key : Key
    , message : String
    , mostRecentRoundTripTime: Int -- ms
    }


type alias BackendModel =
    { message : String
    }


type FrontendMsg
    = UrlClicked UrlRequest
    | UrlChanged Url
    | Tick Time.Posix
    | GotResponse Time.Posix Time.Posix
    | NoOpFrontendMsg


type ToBackend
    = Request Time.Posix


type BackendMsg
    = NoOpBackendMsg


type ToFrontend
    = Response Time.Posix