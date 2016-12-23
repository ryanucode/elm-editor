port module Lib.Ports exposing (..)

import Lib.Types exposing (..)

port gotToken : (Token -> msg) -> Sub msg
port gotExercise : (Exercise -> msg) -> Sub msg
port newExercise : (String -> msg) -> Sub msg