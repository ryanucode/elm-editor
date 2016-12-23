module Main exposing (..)

import Html exposing (..)
import Html.Attributes as Attr
import Html.Events as Event
import Http
import Json.Encode as Encode
import Json.Decode as Decode
import List.Extra

import Markdown
import Material
import Material.Layout as Layout
import Material.Button as Button
import Material.Grid as Grid exposing (..)
import Material.Elevation as Elevation
import Material.Icon as Icon
import Material.Tabs as Tabs
import Material.Options as Options exposing (cs, css) 
import Material.Color as Color exposing (color, Shade(..), Hue(..))
import Material.Toggles as Toggles
import Material.Textfield as Textfield

-- Sub Modules

import Editor

main =
    Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subs
    }

-- Model
type alias Model = 
  { mdl : Material.Model
  , edState : Editor.State
  , text : String
  }

initModel : Model 
initModel =
  { mdl = Material.model
  , edState = Editor.defaultState
  , text = "# Here is an Amazing Editor\nThis is why it is amazing:\n  * it works!\n  * it's made by Ryan!\n  * it's functional!"
  }
 
init : (Model, Cmd Msg)
init = (initModel, Material.init Mdl)

edConfig : Editor.Config
edConfig = Editor.defaultConfig

-- Messages
type Msg = NoOp
         | Mdl (Material.Msg Msg)


-- Update
update : Msg -> Model -> (Model, Cmd Msg)
update msg model = 
  case msg of
    NoOp ->
        (model, Cmd.none)
        
    Mdl msg_ ->
        Material.update msg_ model


-- Subscriptions
subs : Model -> Sub Msg
subs model = Sub.batch 
    [ Material.subscriptions Mdl model
    ]


-- View
editor = Editor.editor edConfig

viewMain : Model -> Html Msg
viewMain model =
    node "main" []
    [ editor model.edState model.text
    , div [Attr.class "preview"] [Markdown.toHtml [] model.text]
    , hr [] []
    , div [Attr.class "debug"] [text <| toString model]
    ]

view : Model -> Html Msg
view model = 
  Layout.render Mdl model.mdl 
    [ Layout.fixedHeader ]
    { header = []
    , drawer = []
    , tabs = ( [], [] )
    , main = [ viewMain model ]
    }
