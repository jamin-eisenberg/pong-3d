module Evergreen.V7.Shapes.Plane exposing (..)

import Evergreen.V7.Internal.Vector3


type alias Plane =
    { normal : Evergreen.V7.Internal.Vector3.Vec3
    , position : Evergreen.V7.Internal.Vector3.Vec3
    }
