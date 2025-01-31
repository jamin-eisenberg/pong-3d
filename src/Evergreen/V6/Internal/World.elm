module Evergreen.V6.Internal.World exposing (..)

import Array
import Evergreen.V6.Internal.Body
import Evergreen.V6.Internal.Constraint
import Evergreen.V6.Internal.Contact
import Evergreen.V6.Internal.Vector3


type alias World data =
    { bodies : List (Evergreen.V6.Internal.Body.Body data)
    , constraints : List Evergreen.V6.Internal.Constraint.ConstraintGroup
    , freeIds : List Int
    , nextBodyId : Int
    , gravity : Evergreen.V6.Internal.Vector3.Vec3
    , contactGroups : List (Evergreen.V6.Internal.Contact.ContactGroup data)
    , simulatedBodies : Array.Array (Evergreen.V6.Internal.Body.Body data)
    }


type Protected data
    = Protected (World data)
