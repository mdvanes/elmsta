module DiceRoller.Update exposing (..)

import Msg as Main exposing (..)
import DiceRoller.Model exposing (DiceRoller, newDiceRoller)
import DiceRoller.Msg exposing (..)
import Random

updateDiceRoller : DiceRollerMsg -> DiceRoller -> DiceRoller
updateDiceRoller msg model =
    case msg of
        Roll ->
            model
        NewFace newFace ->
            { model | dieFace = newFace}

updateDiceRollerCmd : Msg -> Cmd Msg
updateDiceRollerCmd msg =
    case msg of
        MsgForDiceRoller Roll ->
            Random.generate NewFace (Random.int 1 100)
                |> Cmd.map MsgForDiceRoller
        _ ->
            Cmd.none