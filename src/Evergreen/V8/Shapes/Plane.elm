module Evergreen.V8.Shapes.Plane exposing (..)

import Evergreen.V8.Internal.Vector3


type alias Plane =
    { normal : Evergreen.V8.Internal.Vector3.Vec3
    , position : Evergreen.V8.Internal.Vector3.Vec3
    }
