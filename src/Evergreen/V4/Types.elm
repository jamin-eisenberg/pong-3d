module Evergreen.V4.Types exposing (..)

import AssocSet
import Pixels
import Quantity


type Key
    = K_Up
    | K_Right
    | K_Down
    | K_Left
    | K_W
    | K_A
    | K_S
    | K_D


type alias Keys =
    AssocSet.Set Key


type alias FrontendModel =
    { keysPressed : Keys
    , viewportSize :
        { width : Quantity.Quantity Int Pixels.Pixels
        , height : Quantity.Quantity Int Pixels.Pixels
        }
    }


type alias BackendModel =
    {}


type FrontendMsg
    = NoOpFrontendMsg
    | KeyDown Key
    | KeyUp Key
    | Tick Float
    | Resize
        { width : Int
        , height : Int
        }


type ToBackend
    = NoOpToBackend
    | PlayerInput Keys


type BackendMsg
    = NoOpBackendMsg


type ToFrontend
    = NoOpToFrontend
