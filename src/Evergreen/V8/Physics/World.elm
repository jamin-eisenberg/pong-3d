module Evergreen.V8.Physics.World exposing (..)

import Evergreen.V8.Internal.World


type alias World data =
    Evergreen.V8.Internal.World.Protected data
