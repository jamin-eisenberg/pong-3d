module Evergreen.V7.Internal.Constraint exposing (..)

import Evergreen.V7.Internal.Shape
import Evergreen.V7.Internal.Vector3


type Constraint coordinates
    = PointToPoint Evergreen.V7.Internal.Vector3.Vec3 Evergreen.V7.Internal.Vector3.Vec3
    | Hinge Evergreen.V7.Internal.Vector3.Vec3 Evergreen.V7.Internal.Vector3.Vec3 Evergreen.V7.Internal.Vector3.Vec3 Evergreen.V7.Internal.Vector3.Vec3
    | Lock Evergreen.V7.Internal.Vector3.Vec3 Evergreen.V7.Internal.Vector3.Vec3 Evergreen.V7.Internal.Vector3.Vec3 Evergreen.V7.Internal.Vector3.Vec3 Evergreen.V7.Internal.Vector3.Vec3 Evergreen.V7.Internal.Vector3.Vec3 Evergreen.V7.Internal.Vector3.Vec3 Evergreen.V7.Internal.Vector3.Vec3
    | Distance Float


type alias ConstraintGroup =
    { bodyId1 : Int
    , bodyId2 : Int
    , constraints : List (Constraint Evergreen.V7.Internal.Shape.CenterOfMassCoordinates)
    }
