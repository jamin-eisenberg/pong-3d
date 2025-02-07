module Evergreen.V8.Types exposing (..)

import AssocSet
import Evergreen.V8.Physics.World
import Lamdera
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


type Side
    = FrontSide
    | BackSide
    | LeftSide
    | RightSide
    | TopSide
    | BottomSide


type Id
    = Ball
    | WallOn Side
    | PlayerOn Side


type alias FrontendModel =
    { keysPressed : AssocSet.Set Key
    , viewportSize :
        { width : Quantity.Quantity Int Pixels.Pixels
        , height : Quantity.Quantity Int Pixels.Pixels
        }
    , world : Evergreen.V8.Physics.World.World Id
    }


type PlayerMovementDirection
    = Up
    | Right
    | Down
    | Left


type alias Player =
    { side : Side
    , clientId : Lamdera.ClientId
    , movementDirection : Maybe PlayerMovementDirection
    }


type alias BackendModel =
    { world : Evergreen.V8.Physics.World.World Id
    , players : List Player
    }


type FrontendMsg
    = NoOpFrontendMsg
    | KeyDown Key
    | KeyUp Key
    | FrontendTick Float
    | Resize
        { width : Int
        , height : Int
        }


type ToBackend
    = NoOpToBackend
    | PlayerInput (AssocSet.Set PlayerMovementDirection)


type BackendMsg
    = NoOpBackendMsg
    | Connected Lamdera.ClientId
    | Disconnected Lamdera.ClientId
    | BackendTick Float


type ToFrontend
    = NoOpToFrontend
    | JoinRejected
    | WorldUpdate (Evergreen.V8.Physics.World.World Id)
