module Editor exposing (..)

import Dict exposing (Dict)

import Html exposing (Html, Attribute)
import Html.Attributes as Attr
import Html.Events as E
import Html.Keyed as Keyed
--import Html.Lazy exposing (lazy, lazy2, lazy3)

import Json.Decode as Json

editor : Config -> State -> String -> Html a
editor config state text =
    toLines text
        |> \l -> Html.div [Attr.class "line"] [Html.text text]

type alias State =
    { cursor : (Int, Int)
    }

type alias Config =
    { language : String
    , lineNumbers : Bool
    , colors : Dict String String
    }

defaultConfig : Config
defaultConfig =
    { language = "markdown"
    , lineNumbers = False
    , colors = Dict.empty
    }

defaultState : State
defaultState =
    { cursor = (0, 0)
    }

toLines : String -> List String
toLines = String.split "\n"

fromLines : List String -> String
fromLines = String.join "\n"
