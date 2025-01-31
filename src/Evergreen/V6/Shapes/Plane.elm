module Evergreen.V6.Shapes.Plane exposing (..)

import Evergreen.V6.Internal.Vector3


type alias Plane =
    { normal : Evergreen.V6.Internal.Vector3.Vec3
    , position : Evergreen.V6.Internal.Vector3.Vec3
    }
