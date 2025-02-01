module Evergreen.V7.Internal.World exposing (..)

import Array
import Evergreen.V7.Internal.Body
import Evergreen.V7.Internal.Constraint
import Evergreen.V7.Internal.Contact
import Evergreen.V7.Internal.Vector3


type alias World data =
    { bodies : List (Evergreen.V7.Internal.Body.Body data)
    , constraints : List Evergreen.V7.Internal.Constraint.ConstraintGroup
    , freeIds : List Int
    , nextBodyId : Int
    , gravity : Evergreen.V7.Internal.Vector3.Vec3
    , contactGroups : List (Evergreen.V7.Internal.Contact.ContactGroup data)
    , simulatedBodies : Array.Array (Evergreen.V7.Internal.Body.Body data)
    }


type Protected data
    = Protected (World data)
