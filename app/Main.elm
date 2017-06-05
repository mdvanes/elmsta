module Main exposing (..)

import Html exposing (Html, div, text, program, button, input, h1)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Components.Foo exposing (myAdder)
import Regex



-- MAIN

main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }


-- MODEL

type alias Model =
    { content : String
    , name: String
    , password: String
    , passwordAgain: String
    , dieFace : Int
    }

init : (Model, Cmd Msg)
init =
  (Model "" "" "" "" 1, Cmd.none)


-- UPDATE
type Msg = Change String
    | Name String
    | Password String
    | PasswordAgain String
    | Roll

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Change newContent ->
      ({ model | content = newContent }, Cmd.none)
    Name name ->
      ({ model | name = name }, Cmd.none)
    Password password ->
      ({ model | password = password }, Cmd.none)
    PasswordAgain password ->
      ({ model | passwordAgain = password }, Cmd.none)
    Roll ->
      (model, Cmd.none)


-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

-- VIEW
view : Model -> Html Msg
view model =
  div []
    [ input [placeholder "Elmsta", onInput Change] []
    , div [] [ text (String.reverse model.content) ]
    , input [ type_ "text", placeholder "Name", onInput Name ] []
    , input [ type_ "password", placeholder "Password", onInput Password ] []
    , input [ type_ "password", placeholder "Re-enter Password", onInput PasswordAgain ] []
    , viewValidation model
    , h1 [] [text (toString model.dieFace) ]
    , button [ onClick Roll ] [ text "Roll" ]
    ]

viewValidation : Model -> Html msg
viewValidation model =
  let
    (color, message) =
      if Regex.contains (Regex.regex "[=!-]") model.password then
        ("red", "Passwords must contain not contain: =, !, -")
      else if (String.length model.password) <= 8 then
        ("red", "Passwords must be longer than 8 chars")
      else if model.password /= model.passwordAgain then
        ("red", "Passwords do not match!")
      else
        ("green", "OK")
  in
    div [ style [("color", color)] ] [ text message ]