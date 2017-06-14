module DiceRoller.View exposing (..)

import Msg as Main exposing (..)
import DiceRoller.Msg exposing (..)
import DiceRoller.Model exposing (..)

import Html exposing (Html, button, h2, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)

import Panel.View exposing (..)

viewDiceRoller : DiceRoller -> Html Msg
viewDiceRoller model =
    viewPanel
        [ button [ onClick (MsgForDiceRoller Roll) ] [ text "Roll 100-sided dice" ]
        , h2 [] [text (toString model.dieFace) ]
        ]