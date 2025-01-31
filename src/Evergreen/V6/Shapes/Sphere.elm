module Evergreen.V6.Shapes.Sphere exposing (..)

import Evergreen.V6.Internal.Matrix3
import Evergreen.V6.Internal.Vector3


type alias Sphere =
    { radius : Float
    , position : Evergreen.V6.Internal.Vector3.Vec3
    , volume : Float
    , inertia : Evergreen.V6.Internal.Matrix3.Mat3
    }
