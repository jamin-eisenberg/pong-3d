module Evergreen.V8.Internal.World exposing (..)

import Array
import Evergreen.V8.Internal.Body
import Evergreen.V8.Internal.Constraint
import Evergreen.V8.Internal.Contact
import Evergreen.V8.Internal.Vector3


type alias World data =
    { bodies : List (Evergreen.V8.Internal.Body.Body data)
    , constraints : List Evergreen.V8.Internal.Constraint.ConstraintGroup
    , freeIds : List Int
    , nextBodyId : Int
    , gravity : Evergreen.V8.Internal.Vector3.Vec3
    , contactGroups : List (Evergreen.V8.Internal.Contact.ContactGroup data)
    , simulatedBodies : Array.Array (Evergreen.V8.Internal.Body.Body data)
    }


type Protected data
    = Protected (World data)
