module Evergreen.V6.Internal.Shape exposing (..)

import Evergreen.V6.Internal.Vector3
import Evergreen.V6.Shapes.Convex
import Evergreen.V6.Shapes.Plane
import Evergreen.V6.Shapes.Sphere


type CenterOfMassCoordinates
    = CenterOfMassCoordinates


type Shape coordinates
    = Convex Evergreen.V6.Shapes.Convex.Convex
    | Plane Evergreen.V6.Shapes.Plane.Plane
    | Sphere Evergreen.V6.Shapes.Sphere.Sphere
    | Particle Evergreen.V6.Internal.Vector3.Vec3
