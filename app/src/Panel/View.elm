module Panel.View exposing (..)

import Html exposing (Html, section)
import Html.Attributes exposing (..)

viewPanel : List (Html msg) -> Html msg
viewPanel msg =
    section [ style[ ("border", "1px solid black")
        , ("background-color", "aliceblue")
        , ("margin", "1rem")
        , ("padding", "1.5rem")
        ] ] msg
    --Card.config [ Card.attrs [] ]
    --    --|> Card.header []
    --    --    [ h2 [] [ text "header" ]
    --    --    ]
    --    |> Card.block []
    --        [ Card.custom <|
    --            msg
    --        ]
    --    |> Card.view