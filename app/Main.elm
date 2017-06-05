module Main exposing (..)

import Html exposing (Html, div, text, program, button, input)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Components.Foo exposing (myAdder)
import Regex



-- MAIN

main =
  Html.beginnerProgram { model = model, view = view, update = update }


-- MODEL

type alias Model =
    { content : String
    , name: String
    , password: String
    , passwordAgain: String
    }

model : Model
model =
  Model "" "" "" ""


-- UPDATE
type Msg = Change String
    | Name String
    | Password String
    | PasswordAgain String

update : Msg -> Model -> Model
update msg model =
  case msg of
    Change newContent ->
      { model | content = newContent }
    Name name ->
      { model | name = name }
    Password password ->
      { model | password = password }
    PasswordAgain password ->
      { model | passwordAgain = password }


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