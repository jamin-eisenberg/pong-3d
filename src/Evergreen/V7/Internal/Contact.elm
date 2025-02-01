module Evergreen.V7.Internal.Contact exposing (..)

import Evergreen.V7.Internal.Body
import Evergreen.V7.Internal.Vector3


type alias Contact =
    { ni : Evergreen.V7.Internal.Vector3.Vec3
    , pi : Evergreen.V7.Internal.Vector3.Vec3
    , pj : Evergreen.V7.Internal.Vector3.Vec3
    }


type alias ContactGroup data =
    { body1 : Evergreen.V7.Internal.Body.Body data
    , body2 : Evergreen.V7.Internal.Body.Body data
    , contacts : List Contact
    }
