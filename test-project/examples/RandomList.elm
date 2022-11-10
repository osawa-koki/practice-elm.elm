import Browser
import Html exposing (..)
import Html.Events exposing (..)
import Random



-- MAIN


main =
  Browser.element
    { init = init
    , update = update
    , subscriptions = subscriptions
    , view = view
    }



-- MODEL


type alias Model =
  { ransomlist : List Int
  }


init : () -> (Model, Cmd Msg)
init _ =
  ( {
    ransomlist = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
  }
  , Cmd.none
  )



-- UPDATE


type Msg
  = Clicked
  | NewFace Int


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Clicked ->
      ( model
      , Random.generate NewFace (Random.int 1 6)
      )

    NewFace newFace ->
      ( { model | ransomlist = List.map (\_ -> newFace) model.ransomlist }
      , Cmd.none
      )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none



-- VIEW


view : Model -> Html Msg
view model =
  div []
    [ h1 [] [ text "random list" ]
    , button [ onClick Clicked ] [ text "Roll" ]
    , ul [] (List.map (\x -> li [] [ text <| String.fromInt x ]) model.ransomlist)
    ]

