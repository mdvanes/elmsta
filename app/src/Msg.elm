module Msg exposing (..)

import DiceRoller.Msg exposing (..)
import Http

type Msg = Change String
    | Name String
    | Password String
    | PasswordAgain String
    | MsgForDiceRoller DiceRollerMsg
    | SearchImages
    | NewSearchResult (Result Http.Error (List String))
    | ChangeTermInput String