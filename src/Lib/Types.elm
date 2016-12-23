module Lib.Types exposing (..)

import Json.Encode as Encode

type alias FileId = String
type alias TokenId = String
type alias ExerciseId = String


type alias HasId a = { a | id : String }

type alias File =
    { id : String
    , name : String
    , filetype : String
    , content : String
    }

type alias Token =
    { exerciseId : String
    , ltiSessionId : String
    , id : String
    }

type alias Exercise =
    { id : String
    , name : String
    , instructions : String
    , givenFileName : String
    , givenHead : String
    , givenBody : String
    , givenTail : String
    , assertions : String
    , solution : String
    , suppressedErrors : List String
    }

type alias AssertionRequest =
    { code : String
    , assertions : List String
    }

type alias AssertionResponse = List String

emptyExercise : Exercise
emptyExercise =
    { id = ""
    , name = "Exercise"
    , instructions = ""
    , givenFileName = ""
    , givenHead = ""
    , givenBody = ""
    , givenTail = ""
    , assertions = ""
    , solution = ""
    , suppressedErrors = [""]
    }

encodeExercise e = Encode.object 
    [ ("id", Encode.string e.id)
    , ("name", Encode.string e.name)
    , ("instructions", Encode.string e.instructions)
    , ("givenFileName", Encode.string e.givenFileName)
    , ("givenHead", Encode.string e.givenHead)
    , ("givenBody", Encode.string e.givenBody)
    , ("givenTail", Encode.string e.givenTail)
    , ("assertions", Encode.string e.assertions)
    , ("solution", Encode.string e.solution)
    , ("suppressedErrors", Encode.list <| List.map Encode.string e.suppressedErrors)
    ]

emptyFile : File
emptyFile =
    { id = ""
    , name = ""
    , filetype = ""
    , content = ""
    }

emptyAssertionFile : File
emptyAssertionFile =
    { id = ""
    , name = "assert.js"
    , filetype = "js"
    , content = "#! node\n"
    }

untitledFile : File
untitledFile = {emptyFile | name = "untitled"}

newFile = Encode.object
    [ ("name", Encode.string emptyFile.name)
    , ("content", Encode.string emptyFile.content)
    , ("filetype", Encode.string emptyFile.filetype)
    ]
