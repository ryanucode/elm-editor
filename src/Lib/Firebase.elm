port module Lib.Firebase exposing (..)

import Lib.Types exposing (..)
import Json.Encode as Encode

type alias FbRef = String
type alias Callback = String
type alias FbEvent = String

port fbUpdate : (FbRef, Encode.Value) -> Cmd msg
port fbRemove : FbRef -> Cmd msg
port fbSet : (FbRef, Encode.Value) -> Cmd msg
port fbPost : (FbRef, Encode.Value, Callback) -> Cmd msg
port fbGet : (FbRef, FbEvent, Callback) -> Cmd msg
port fbOn : (FbRef, FbEvent, Callback) -> Cmd msg

timestamp : String -> List (String, Encode.Value) -> List (String, Encode.Value)
timestamp tsFieldName value = (tsFieldName, timestampValue) :: value

timestampValue : Encode.Value
timestampValue = Encode.object [(".sv", Encode.string "timestamp")]
