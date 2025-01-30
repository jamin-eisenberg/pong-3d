module Evergreen.V2.Types exposing (..)

import Browser
import Browser.Navigation
import Time
import Url


type alias FrontendModel =
    { key : Browser.Navigation.Key
    , message : String
    , mostRecentRoundTripTime : Int
    }


type alias BackendModel =
    { message : String
    }


type FrontendMsg
    = UrlClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | Tick Time.Posix
    | GotResponse Time.Posix Time.Posix
    | NoOpFrontendMsg


type ToBackend
    = Request Time.Posix


type BackendMsg
    = NoOpBackendMsg


type ToFrontend
    = Response Time.Posix
