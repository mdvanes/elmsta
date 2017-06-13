module DiceRoller.Model exposing (..)

type alias DiceRoller = {
    dieFace : Int
    }

newDiceRoller : DiceRoller
newDiceRoller =
    { dieFace = 1
    }

model : DiceRoller
model =
    newDiceRoller