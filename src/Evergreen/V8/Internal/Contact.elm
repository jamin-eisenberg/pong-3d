module Evergreen.V8.Internal.Contact exposing (..)

import Evergreen.V8.Internal.Body
import Evergreen.V8.Internal.Vector3


type alias Contact =
    { ni : Evergreen.V8.Internal.Vector3.Vec3
    , pi : Evergreen.V8.Internal.Vector3.Vec3
    , pj : Evergreen.V8.Internal.Vector3.Vec3
    }


type alias ContactGroup data =
    { body1 : Evergreen.V8.Internal.Body.Body data
    , body2 : Evergreen.V8.Internal.Body.Body data
    , contacts : List Contact
    }
