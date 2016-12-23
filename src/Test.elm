import Html exposing (Html, div, text)
import Html exposing (beginnerProgram)
import Html.Events exposing (onBlur, on)
import Html.Attributes exposing (contenteditable, id)
import Json.Decode as Json
import Debug

--main : Program Never
main = beginnerProgram { model = "Hello" , view = view , update = update }

type alias Model = String

view : Model -> Html Msg
view model =
  div [ contenteditable True ,on "input" (Json.map SaveInput     targetTextContent)]
    [ text model ]

targetTextContent : Json.Decoder String
targetTextContent =
  Json.at ["target", "textContent"] Json.string

type Msg = SaveInput String

update : Msg -> Model -> Model
update msg model =
  case msg of
    SaveInput str -> (Debug.log "saving" str)
