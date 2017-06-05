module Main exposing (..)

import Html exposing (Html, div, text, program, button, input)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Components.Foo exposing (myAdder)

-- resume tutorial at: Foundations / Union Types

-- main =
--    text (toString(myAdder 1 2))


-- type alias Model =
--     String
--
-- init : ( Model, Cmd Msg )
-- init =
--     ( "Hello", Cmd.none )
--
-- type Msg
--     = NoOp
--     , Change String
--
-- -- VIEW
-- view : Model -> Html Msg
-- view model =
--     div []
--         [ input [ placeholder "search elmstragrams", onInput NoOp ] []
--         , button [ onClick NoOp ] [ text "search" ]
--         , text "hello"
--         ]
--
-- -- UPDATE
-- update : Msg -> Model -> ( Model, Cmd Msg )
-- update msg model =
--     case msg of
--         NoOp ->
--             ( model, Cmd.none )
--
-- -- SUBSCRIPTIONS
-- subscriptions : Model -> Sub Msg
-- subscriptions model =
--     Sub.none
--
-- -- MAIN
-- main : Program Never Model Msg
-- main =
--     program
--         { init = init
--         , view = view
--         , update = update
--         , subscriptions = subscriptions
--         }


-- MAIN

main =
  Html.beginnerProgram { model = model, view = view, update = update }


-- MODEL

type alias Model =
    { content : String
    }

model : Model
model =
  { content = "" }


-- UPDATE
type Msg =
    Change String

update : Msg -> Model -> Model
update msg model =
  case msg of
    Change newContent ->
      { model | content = newContent }


-- VIEW
view : Model -> Html Msg
view model =
  div []
    [ input [placeholder "Elmsta", onInput Change] []
    , div [] [ text (String.reverse model.content) ]
    ]
