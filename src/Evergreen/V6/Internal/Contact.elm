module Evergreen.V6.Internal.Contact exposing (..)

import Evergreen.V6.Internal.Body
import Evergreen.V6.Internal.Vector3


type alias Contact =
    { ni : Evergreen.V6.Internal.Vector3.Vec3
    , pi : Evergreen.V6.Internal.Vector3.Vec3
    , pj : Evergreen.V6.Internal.Vector3.Vec3
    }


type alias ContactGroup data =
    { body1 : Evergreen.V6.Internal.Body.Body data
    , body2 : Evergreen.V6.Internal.Body.Body data
    , contacts : List Contact
    }
