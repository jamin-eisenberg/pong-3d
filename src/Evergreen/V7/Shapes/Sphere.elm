module Evergreen.V7.Shapes.Sphere exposing (..)

import Evergreen.V7.Internal.Matrix3
import Evergreen.V7.Internal.Vector3


type alias Sphere =
    { radius : Float
    , position : Evergreen.V7.Internal.Vector3.Vec3
    , volume : Float
    , inertia : Evergreen.V7.Internal.Matrix3.Mat3
    }
