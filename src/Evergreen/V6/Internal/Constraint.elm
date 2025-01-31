module Evergreen.V6.Internal.Constraint exposing (..)

import Evergreen.V6.Internal.Shape
import Evergreen.V6.Internal.Vector3


type Constraint coordinates
    = PointToPoint Evergreen.V6.Internal.Vector3.Vec3 Evergreen.V6.Internal.Vector3.Vec3
    | Hinge Evergreen.V6.Internal.Vector3.Vec3 Evergreen.V6.Internal.Vector3.Vec3 Evergreen.V6.Internal.Vector3.Vec3 Evergreen.V6.Internal.Vector3.Vec3
    | Lock Evergreen.V6.Internal.Vector3.Vec3 Evergreen.V6.Internal.Vector3.Vec3 Evergreen.V6.Internal.Vector3.Vec3 Evergreen.V6.Internal.Vector3.Vec3 Evergreen.V6.Internal.Vector3.Vec3 Evergreen.V6.Internal.Vector3.Vec3 Evergreen.V6.Internal.Vector3.Vec3 Evergreen.V6.Internal.Vector3.Vec3
    | Distance Float


type alias ConstraintGroup =
    { bodyId1 : Int
    , bodyId2 : Int
    , constraints : List (Constraint Evergreen.V6.Internal.Shape.CenterOfMassCoordinates)
    }
