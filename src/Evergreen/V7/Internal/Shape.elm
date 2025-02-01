module Evergreen.V7.Internal.Shape exposing (..)

import Evergreen.V7.Internal.Vector3
import Evergreen.V7.Shapes.Convex
import Evergreen.V7.Shapes.Plane
import Evergreen.V7.Shapes.Sphere


type CenterOfMassCoordinates
    = CenterOfMassCoordinates


type Shape coordinates
    = Convex Evergreen.V7.Shapes.Convex.Convex
    | Plane Evergreen.V7.Shapes.Plane.Plane
    | Sphere Evergreen.V7.Shapes.Sphere.Sphere
    | Particle Evergreen.V7.Internal.Vector3.Vec3
