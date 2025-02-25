module Evergreen.V8.Internal.Constraint exposing (..)

import Evergreen.V8.Internal.Shape
import Evergreen.V8.Internal.Vector3


type Constraint coordinates
    = PointToPoint Evergreen.V8.Internal.Vector3.Vec3 Evergreen.V8.Internal.Vector3.Vec3
    | Hinge Evergreen.V8.Internal.Vector3.Vec3 Evergreen.V8.Internal.Vector3.Vec3 Evergreen.V8.Internal.Vector3.Vec3 Evergreen.V8.Internal.Vector3.Vec3
    | Lock Evergreen.V8.Internal.Vector3.Vec3 Evergreen.V8.Internal.Vector3.Vec3 Evergreen.V8.Internal.Vector3.Vec3 Evergreen.V8.Internal.Vector3.Vec3 Evergreen.V8.Internal.Vector3.Vec3 Evergreen.V8.Internal.Vector3.Vec3 Evergreen.V8.Internal.Vector3.Vec3 Evergreen.V8.Internal.Vector3.Vec3
    | Distance Float


type alias ConstraintGroup =
    { bodyId1 : Int
    , bodyId2 : Int
    , constraints : List (Constraint Evergreen.V8.Internal.Shape.CenterOfMassCoordinates)
    }
