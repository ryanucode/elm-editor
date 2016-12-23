module Lib.Util exposing (..)

import Lib.Types exposing (..)
import List.Extra exposing (find)
import Maybe exposing (withDefault)

getById : List (HasId a) -> String -> Maybe (HasId a)
getById list id = find (\u -> u.id == id) list

exerciseToAssertionRequest : Exercise -> AssertionRequest
exerciseToAssertionRequest exercise = Debug.crash "undefined"

runAssertions : String -> AssertionRequest -> List String
runAssertions url exercise = Debug.crash "undefined"

