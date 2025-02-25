module Evergreen.V7.Internal.Body exposing (..)

import Evergreen.V7.Internal.Material
import Evergreen.V7.Internal.Matrix3
import Evergreen.V7.Internal.Shape
import Evergreen.V7.Internal.Transform3d
import Evergreen.V7.Internal.Vector3
import Evergreen.V7.Physics.Coordinates


type alias Body data =
    { id : Int
    , data : data
    , material : Evergreen.V7.Internal.Material.Material
    , transform3d :
        Evergreen.V7.Internal.Transform3d.Transform3d
            Evergreen.V7.Physics.Coordinates.WorldCoordinates
            { defines : Evergreen.V7.Internal.Shape.CenterOfMassCoordinates
            }
    , centerOfMassTransform3d :
        Evergreen.V7.Internal.Transform3d.Transform3d
            Evergreen.V7.Physics.Coordinates.BodyCoordinates
            { defines : Evergreen.V7.Internal.Shape.CenterOfMassCoordinates
            }
    , velocity : Evergreen.V7.Internal.Vector3.Vec3
    , angularVelocity : Evergreen.V7.Internal.Vector3.Vec3
    , mass : Float
    , shapes : List (Evergreen.V7.Internal.Shape.Shape Evergreen.V7.Internal.Shape.CenterOfMassCoordinates)
    , worldShapes : List (Evergreen.V7.Internal.Shape.Shape Evergreen.V7.Physics.Coordinates.WorldCoordinates)
    , force : Evergreen.V7.Internal.Vector3.Vec3
    , torque : Evergreen.V7.Internal.Vector3.Vec3
    , boundingSphereRadius : Float
    , linearDamping : Float
    , angularDamping : Float
    , invMass : Float
    , invInertia : Evergreen.V7.Internal.Matrix3.Mat3
    , invInertiaWorld : Evergreen.V7.Internal.Matrix3.Mat3
    }
