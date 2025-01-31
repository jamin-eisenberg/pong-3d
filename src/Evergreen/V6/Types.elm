module Evergreen.V6.Types exposing (..)

import AssocSet
import Evergreen.V6.Physics.World
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


type alias FrontendModel =
    { keysPressed : AssocSet.Set Key
    , viewportSize :
        { width : Quantity.Quantity Int Pixels.Pixels
        , height : Quantity.Quantity Int Pixels.Pixels
        }
    }


type alias BackendModel =
    { world : Evergreen.V6.Physics.World.World Int
    }


type FrontendMsg
    = NoOpFrontendMsg
    | KeyDown Key
    | KeyUp Key
    | Tick Float
    | Resize
        { width : Int
        , height : Int
        }


type PlayerMovementDirection
    = Up
    | Right
    | Down
    | Left


type ToBackend
    = NoOpToBackend
    | PlayerInput (AssocSet.Set PlayerMovementDirection)


type BackendMsg
    = NoOpBackendMsg


type ToFrontend
    = NoOpToFrontend
