module Evergreen.V7.Internal.Transform3d exposing (..)

import Evergreen.V7.Internal.Vector3


type Orientation3d
    = Orientation3d Float Float Float Float


type Transform3d coordinates defines
    = Transform3d Evergreen.V7.Internal.Vector3.Vec3 Orientation3d
