port module CopyText exposing (..)

import Browser
import Html exposing (..)
import Html.Events exposing (onClick)


main : Program () Model Msg
main =
  Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Model =
  String


init : Model
init =
  ""



-- UPDATE


type Msg = Copy

update : Msg -> Model -> Model
update msg model =
  case msg of
    Copy ->
      let
        a = Debug.log "copy" model
        b = copy ()
      in
        model

port copy : () -> Cmd msg

-- VIEW
view : Model -> Html Msg
view model =
  div []
    [ input [] []
    , button [ onClick Copy ] [ text "copy" ]
    ]


