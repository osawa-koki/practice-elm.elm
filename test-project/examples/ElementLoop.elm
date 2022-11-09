module HelloWorld exposing (main)

import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)


main : Program () Model Msg
main =
  Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Model = {
  messages : List String
  }


init : Model
init =
  { messages = ["HI", "Hello", "Good Morning"] }



-- UPDATE


type Msg
  = Nothing


update : Msg -> Model -> Model
update msg model =
  model



-- VIEW


view : Model -> Html Msg
view model =
  div [] <| List.map viewList model.messages

viewList : String -> Html Msg
viewList message =
  div [] [ text message ]

