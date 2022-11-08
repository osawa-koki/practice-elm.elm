import Browser
import Html exposing (Html, button, div, text, node)
import Html.Events exposing (onClick)
import Html.Attributes exposing (class)


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


type Msg
  = ToggleText


update : Msg -> Model -> Model
update msg model =
  case msg of
    ToggleText ->
      if model == "" then
        "Hello World!"

      else
        ""



-- VIEW


view : Model -> Html Msg
view model =
  node "main" []
    [ button [ onClick ToggleText ] [ text "Toggle text" ]
    , div [ class "A" ] [ text model ]
    ]
