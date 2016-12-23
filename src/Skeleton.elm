module Skeleton exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Http exposing (..)
import Html.Events as Event
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
  }

initialModel : Model 
initialModel = 
  { mdl = Material.model
  }
 
init : (Model, Cmd Msg)
init = (initialModel, Material.init Mdl)

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
viewMain : Model -> Html Msg
viewMain model =
    div []
    []

view : Model -> Html Msg
view model = 
  Layout.render Mdl model.mdl 
    [ Layout.fixedHeader ]
    { header = []
    , drawer = []
    , tabs = ( [], [] )
    , main = [ viewMain model ]
    }
