module Types exposing (..)

import Evergreen.V1.Types exposing (ToFrontend(..))
import Lamdera exposing (ClientId)
import Url exposing (Url)


type alias FrontendModel =
    {}


type alias BackendModel =
    {}


type FrontendMsg
    = NoOpFrontendMsg


type ToBackend
    = NoOpToBackend


type BackendMsg
    = NoOpBackendMsg


type ToFrontend
    = NoOpToFrontend
