-- ===== ===== ===== ===== =====
-- https://bombrary.github.io/blog/posts/elm-todo-list/
-- ===== ===== ===== ===== =====

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)

main =
  Browser.sandbox { init = init, update = update, view = view }

--Model

type alias Todo =
  { description : String
  }

type alias Model =
  { todos : List Todo
  , input : Todo
  }

init : Model
init =
  { todos = []
  , input = Todo ""
  }

type Msg = Add | Change String

--Update

update : Msg -> Model -> Model
update msg model =
  case msg of
    Add ->
      { model | todos = model.input :: model.todos }
    Change str ->
      { model | input = Todo str }

-- View

view : Model -> Html Msg
view model =
  div []
    [ input [ type_ "text", placeholder "What will you do?", onInput Change] []
    , button [ onClick Add ] [ text "Add" ]
    , ul [] (List.map viewLi model.todos)
    ]

viewLi : Todo -> Html Msg
viewLi todo =
  li [] [ text todo.description ]

