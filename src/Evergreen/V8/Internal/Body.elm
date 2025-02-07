module Evergreen.V8.Internal.Body exposing (..)

import Evergreen.V8.Internal.Material
import Evergreen.V8.Internal.Matrix3
import Evergreen.V8.Internal.Shape
import Evergreen.V8.Internal.Transform3d
import Evergreen.V8.Internal.Vector3
import Evergreen.V8.Physics.Coordinates


type alias Body data =
    { id : Int
    , data : data
    , material : Evergreen.V8.Internal.Material.Material
    , transform3d :
        Evergreen.V8.Internal.Transform3d.Transform3d
            Evergreen.V8.Physics.Coordinates.WorldCoordinates
            { defines : Evergreen.V8.Internal.Shape.CenterOfMassCoordinates
            }
    , centerOfMassTransform3d :
        Evergreen.V8.Internal.Transform3d.Transform3d
            Evergreen.V8.Physics.Coordinates.BodyCoordinates
            { defines : Evergreen.V8.Internal.Shape.CenterOfMassCoordinates
            }
    , velocity : Evergreen.V8.Internal.Vector3.Vec3
    , angularVelocity : Evergreen.V8.Internal.Vector3.Vec3
    , mass : Float
    , shapes : List (Evergreen.V8.Internal.Shape.Shape Evergreen.V8.Internal.Shape.CenterOfMassCoordinates)
    , worldShapes : List (Evergreen.V8.Internal.Shape.Shape Evergreen.V8.Physics.Coordinates.WorldCoordinates)
    , force : Evergreen.V8.Internal.Vector3.Vec3
    , torque : Evergreen.V8.Internal.Vector3.Vec3
    , boundingSphereRadius : Float
    , linearDamping : Float
    , angularDamping : Float
    , invMass : Float
    , invInertia : Evergreen.V8.Internal.Matrix3.Mat3
    , invInertiaWorld : Evergreen.V8.Internal.Matrix3.Mat3
    }
