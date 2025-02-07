module Evergreen.V8.Internal.Shape exposing (..)

import Evergreen.V8.Internal.Vector3
import Evergreen.V8.Shapes.Convex
import Evergreen.V8.Shapes.Plane
import Evergreen.V8.Shapes.Sphere


type CenterOfMassCoordinates
    = CenterOfMassCoordinates


type Shape coordinates
    = Convex Evergreen.V8.Shapes.Convex.Convex
    | Plane Evergreen.V8.Shapes.Plane.Plane
    | Sphere Evergreen.V8.Shapes.Sphere.Sphere
    | Particle Evergreen.V8.Internal.Vector3.Vec3
