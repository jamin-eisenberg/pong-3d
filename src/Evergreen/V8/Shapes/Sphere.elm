module Evergreen.V8.Shapes.Sphere exposing (..)

import Evergreen.V8.Internal.Matrix3
import Evergreen.V8.Internal.Vector3


type alias Sphere =
    { radius : Float
    , position : Evergreen.V8.Internal.Vector3.Vec3
    , volume : Float
    , inertia : Evergreen.V8.Internal.Matrix3.Mat3
    }
