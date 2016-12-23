module Editor exposing (..)

import Dict exposing (Dict)
import String.Extra as SE exposing (..)
import List.Extra as LE

import Html exposing (Html, Attribute)
import Html.Attributes as Attr
import Html.Events as Event
import Html.Keyed as Keyed
--import Html.Lazy exposing (lazy, lazy2, lazy3)

import Json.Decode as Decode exposing (Decoder)

editor : Config msg -> State -> String -> Html msg
editor config state text =
    let
        indexToLn = \fn n t -> fn (n+1) t
        lineRenderer ln text =
            Html.div
                [ Attr.class "line"
                , Attr.contenteditable True
                , Event.on "input" <| Decode.map (config.inputCmd ln) targetTextContent
                ]
                [Html.text text]
        lines = 
            String.lines text
                |> List.indexedMap (indexToLn lineRenderer)
    in
        Html.div [Attr.class "elm-editor"] lines

targetTextContent : Decoder String
targetTextContent =
    Decode.at ["target", "textContent"] Decode.string

type alias State =
    { cursor : (Int, Int)
    }

type alias Config msg =
    { language : String
    , toMsg : State -> msg
    , lineNumbers : Bool
    , colorscheme : Dict String String
    , highlighter : Highlighter
    , inputCmd : Int -> String -> msg
    }

-- this is the type for making performant adjustments to a line
--                      before   current after
type alias LineSplice = (String, String, String)

lineCount : String -> Int
lineCount = countOccurrences "\n"
--lineCount =
    --let
        --counter char accum =
            --if char == '\n' then accum + 1 else accum
    --in
        --foldl counter 0

updateAtLine : String -> Int -> String -> String
updateAtLine text ln new =
    let
        lines = String.lines text
    in
        LE.updateIfIndex ((==) (ln - 1))  (\_ -> new) lines
            |> fromLines


-- Syntax Highlighting

type alias Highlighting = List String
type alias HighlightedLine = List (Highlighting, String)
-- the gist here is that a highlighter takes lines and chops each line into
-- spans with specific highlighting class names
type alias Highlighter = List String -> List (HighlightedLine)

plaintext : Highlighter
plaintext =
    List.map (\l -> [([], l)])

defaultConfig : {inputCmd: Int -> String -> msg , toMsg: State -> msg} -> Config msg
defaultConfig {toMsg, inputCmd} =
    { language = "markdown"
    , toMsg = toMsg
    , lineNumbers = False
    , colorscheme = Dict.empty
    , highlighter = plaintext
    , inputCmd = inputCmd
    }

defaultState : State
defaultState =
    { cursor = (0, 0)
    }

fromLines : List String -> String
fromLines = String.join "\n"
