module Types exposing (..)

import AssocSet exposing (Set)
import Direction2d exposing (Direction2d)
import Evergreen.V1.Types exposing (ToFrontend(..))
import Lamdera exposing (ClientId)
import Physics.World exposing (World)
import Pixels exposing (Pixels)
import Quantity exposing (Quantity)
import Speed exposing (MetersPerSecond)
import Url exposing (Url)
import Vector2d exposing (Vector2d)


type alias FrontendModel =
    { keysPressed : Set Key
    , viewportSize : { width : Quantity Int Pixels, height : Quantity Int Pixels }
    , world : World Id
    }


type FrontendPlayerCoordinates
    = FrontendPlayerCoordinates


type alias BackendModel =
    { world : World Id
    , players : List Player
    }


type alias Player =
    { side : Side
    , clientId : ClientId
    , movementDirection : Maybe PlayerMovementDirection
    }


type Id
    = Ball
    | WallOn Side
    | PlayerOn Side


type Side
    = FrontSide
    | BackSide
    | LeftSide
    | RightSide
    | TopSide
    | BottomSide


type FrontendMsg
    = NoOpFrontendMsg
    | KeyDown Key
    | KeyUp Key
    | FrontendTick Float -- delta time in ms
    | Resize { width : Int, height : Int }


type Key
    = K_Up
    | K_Right
    | K_Down
    | K_Left
    | K_W
    | K_A
    | K_S
    | K_D


type PlayerMovementDirection
    = Up
    | Right
    | Down
    | Left


type ToBackend
    = NoOpToBackend
    | PlayerInput (Set PlayerMovementDirection)


type BackendMsg
    = NoOpBackendMsg
    | Connected ClientId
    | Disconnected ClientId
    | BackendTick Float -- delta time in ms


type ToFrontend
    = NoOpToFrontend
    | JoinRejected
    | WorldUpdate (World Id)
