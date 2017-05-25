module Main exposing (..)

import Html exposing (Html, div, text, program, button)
import Html.Events exposing (onClick)
import Components.Foo exposing (myAdder)

-- resume tutorial at: Foundations / Union Types

-- main =
--    text (toString(myAdder 1 2))


type alias Model =
    String

init : ( Model, Cmd Msg )
init =
    ( "Hello", Cmd.none )

type Msg
    = NoOp

-- VIEW
view : Model -> Html Msg
view model =
    div []
        [ button [ onClick NoOp ] [ text "search" ]
        , text "hello"
        ]

-- UPDATE
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

-- MAIN
main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }