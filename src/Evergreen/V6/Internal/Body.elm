module Evergreen.V6.Internal.Body exposing (..)

import Evergreen.V6.Internal.Material
import Evergreen.V6.Internal.Matrix3
import Evergreen.V6.Internal.Shape
import Evergreen.V6.Internal.Transform3d
import Evergreen.V6.Internal.Vector3
import Evergreen.V6.Physics.Coordinates


type alias Body data =
    { id : Int
    , data : data
    , material : Evergreen.V6.Internal.Material.Material
    , transform3d :
        Evergreen.V6.Internal.Transform3d.Transform3d
            Evergreen.V6.Physics.Coordinates.WorldCoordinates
            { defines : Evergreen.V6.Internal.Shape.CenterOfMassCoordinates
            }
    , centerOfMassTransform3d :
        Evergreen.V6.Internal.Transform3d.Transform3d
            Evergreen.V6.Physics.Coordinates.BodyCoordinates
            { defines : Evergreen.V6.Internal.Shape.CenterOfMassCoordinates
            }
    , velocity : Evergreen.V6.Internal.Vector3.Vec3
    , angularVelocity : Evergreen.V6.Internal.Vector3.Vec3
    , mass : Float
    , shapes : List (Evergreen.V6.Internal.Shape.Shape Evergreen.V6.Internal.Shape.CenterOfMassCoordinates)
    , worldShapes : List (Evergreen.V6.Internal.Shape.Shape Evergreen.V6.Physics.Coordinates.WorldCoordinates)
    , force : Evergreen.V6.Internal.Vector3.Vec3
    , torque : Evergreen.V6.Internal.Vector3.Vec3
    , boundingSphereRadius : Float
    , linearDamping : Float
    , angularDamping : Float
    , invMass : Float
    , invInertia : Evergreen.V6.Internal.Matrix3.Mat3
    , invInertiaWorld : Evergreen.V6.Internal.Matrix3.Mat3
    }
