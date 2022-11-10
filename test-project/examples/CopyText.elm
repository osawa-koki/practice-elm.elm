port module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as D



-- MAIN


main : Program () Model Msg
main =
  Browser.element
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }




-- PORTS


port copy_to_clip : String -> Cmd msg
port messageReceiver : (String -> msg) -> Sub msg



-- MODEL


type alias Model =
  { draft : String
  , messages : List String
  }


init : () -> ( Model, Cmd Msg )
init flags =
  ( { draft = "", messages = [] }
  , Cmd.none
  )



-- UPDATE


type Msg
  = DraftChanged String
  | CopyToClip
  | Recv String


-- ユーザーがエンターキーを押すか、CopyToClip ボタンをクリックしたとき、`copy_to_clip`ポートを使っています。
-- これがどんなふうにWebSocketとつながっているのかindex.htmlにあるJavaScriptと対応させてみてください。
--
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    DraftChanged draft ->
      ( { model | draft = draft }
      , Cmd.none
      )

    CopyToClip ->
      ( { model | draft = "" }
      , copy_to_clip model.draft
      )

    Recv message ->
      ( { model | messages = model.messages ++ [message] }
      , Cmd.none
      )



-- SUBSCRIPTIONS


-- `messageReceiver`ポートを使って、JavaScriptから送られるメッセージを待ち受けています。
-- どうやってWebSocketとつながっているのかは、index.htmlファイルを見てください。
--
subscriptions : Model -> Sub Msg
subscriptions _ =
  messageReceiver Recv



-- VIEW


view : Model -> Html Msg
view model =
  div []
    [ h1 [] [ text "Copy That" ]
    , input
        [ type_ "text"
        , placeholder "anything you want to copy"
        , onInput DraftChanged
        , on "keydown" (ifIsEnter CopyToClip)
        , value model.draft
        ]
        []
    , button [ onClick CopyToClip ] [ text "CopyToClip" ]
    , div [] []
    , textarea [ rows 40, cols 40 ] []
    ]



-- DETECT ENTER


ifIsEnter : msg -> D.Decoder msg
ifIsEnter msg =
  D.field "key" D.string
    |> D.andThen (\key -> if key == "Enter" then D.succeed msg else D.fail "some other key")


