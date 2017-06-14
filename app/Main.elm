module Main exposing (..)

import Html exposing (Html, div, text, program, button, input, h1, h2, img, br, ul, li, a, section)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Http
import Json.Decode as Decode
import Components.Foo exposing (myAdder)
import Regex

import Msg as Main exposing (..)

import DiceRoller.Model exposing (..)
import DiceRoller.Msg exposing (..)
import DiceRoller.Update exposing (..)

import Panel.View exposing (..)
import GithubBanner.View exposing (..)
import DiceRoller.View exposing (..)

import Bootstrap.CDN as CDN
import Bootstrap.Grid as Grid
import Bootstrap.Grid.Col as Col
import Bootstrap.Alert as Alert
import Bootstrap.Card as Card
import Bootstrap.Form as Form
import Bootstrap.Form.Input as Input

-- Continue tutorial at Effects/Time

-- Not possible at the moment: https://groups.google.com/forum/#!topic/elm-discuss/khUMddCweEw
--port title : String
--port title = "Test"

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
    , diceRoller : DiceRoller
    , termInput : String
    , termResult : List String
    }

init : (Model, Cmd Msg)
init =
  (Model "" "" "" "" newDiceRoller "Elm" [], Cmd.none)


-- UPDATE
updateCmd : Msg -> Model -> Cmd Msg
updateCmd msg model =
    Cmd.batch
        [ updateDiceRollerCmd msg
        , getSearchResult model.termInput
        ]

updateModel : Msg -> Model -> Model
updateModel msg model =
    case msg of
        Change newContent ->
            { model | content = newContent }
        Name name ->
            { model | name = name }
        Password password ->
            { model | password = password }
        PasswordAgain password ->
            { model | passwordAgain = password }
        MsgForDiceRoller msg ->
            { model | diceRoller = updateDiceRoller msg model.diceRoller}
        SearchImages ->
            model
        NewSearchResult (Ok newResult) ->
            { model | termResult = newResult }
        NewSearchResult (Err _) ->
            model
        ChangeTermInput term ->
            { model | termInput = term}

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    (updateModel msg model, updateCmd msg model)

getSearchResult : String -> Cmd Msg
getSearchResult term =
    let
        url =
            -- Giphy random
            -- "https://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=" ++ term
            -- Instagram API - requires authentication: https://www.instagram.com/developer/
            -- Wikipedia
            --"https://en.wikipedia.org/w/api.php?action=query&format=json&list=search&srsearch=" ++ term
            -- Wikipedia CORS - `https://cors-anywhere.herokuapp.com/en.wikipedia.org:443/w/api.php?action=query&format=json&list=search&srsearch=${encodeURI(term)}`
            "https://cors-anywhere.herokuapp.com/en.wikipedia.org:443/w/api.php?action=query&format=json&list=search&srsearch=" ++ term
        request =
            Http.get url decodeWikipediaResults
    in
        Http.send NewSearchResult request

decodeGifUrl : Decode.Decoder String
decodeGifUrl =
    Decode.at ["data", "image_url"] Decode.string

decodeWikipediaResults : Decode.Decoder (List String)
decodeWikipediaResults =
    -- data.detail.response.query.search
    -- works on elm repl: decodeString (field "query" (field "search" string)) """{"query": {"search": "bla"} } """
    -- works on elm repl: decodeString (field "query" (field "search" (list (field "title" string)))) """{"query": {"search": [{"title": "bla"}]} } """
    -- Decode.at ["query", "search"] Decode.string
    Decode.field "query" (Decode.field "search" (Decode.list (Decode.field "title" Decode.string)))

-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

-- VIEW
view : Model -> Html Msg
view model =
    div []
    [ viewGithubBanner
    , Grid.container []
        [ CDN.stylesheet
        , div []
            [ h1 [ style[("font-family", "sans-serif"), ("margin", "1rem")] ] [text "Elm Test Page"]
            , viewPanel
                [ Grid.row []
                    [ Grid.col [ Col.xs12, Col.md6 ]
                        [ Form.group []
                            [ Input.text [ Input.attrs
                                [ placeholder "Reverse text"
                                , onInput Change ] ]
                            ]
                        ]
                    , Grid.col [ Col.xs12, Col.md6 ]
                        [ text (String.reverse model.content) ]
                    ]
                ]
        , viewPanel
            [ Grid.row []
                [ Grid.col [ Col.xs12, Col.md6 ]
                    [ Form.form []
                        [ Form.group []
                            [ Form.label [] [ text "Name" ]
                            , Input.text [ Input.attrs [ placeholder "Type your name here", onInput Name ] ]
                            ]
                        , Form.group []
                            [ Form.label [] [ text "Password" ]
                            , Input.text [ Input.attrs [ type_ "password", onInput Password ] ]
                            ]
                        , Form.group []
                            [ Form.label [] [ text "Re-enter Password" ]
                            , Input.text [ Input.attrs [ type_ "password", onInput PasswordAgain ] ]
                            ]
                        ]
                    ]
                ]
            , viewValidation model
            ]
        , viewDiceRoller model.diceRoller
        , viewPanel [ h2 [ style[("font-family", "sans-serif")] ] [text (String.append "Searching " model.termInput)]
            , input [placeholder "Elmsta search term", onInput ChangeTermInput, value model.termInput] []
            , br [] []
            -- , img [src model.termResult] []
            -- , div [] [ text (String.join ";" model.termResult) ]
            , viewTermResultList model
            , br [] []
            , button [ onClick SearchImages ] [ text "Search Wiki" ]
            ]
        ]
        ]
    ]


viewTermResultList : Model -> Html msg
viewTermResultList model =
  let
    items = List.map (\l -> li [] [ text l ]) model.termResult
  in
    ul [ style[("color", "#887c7c"), ("font-family", "sans-serif")] ] items

viewValidation : Model -> Html msg
viewValidation model =
  let
    (color, message, alerttype) =
      if Regex.contains (Regex.regex "[=!-]") model.password then
        ("red", "Passwords must contain not contain: =, !, -", Alert.danger)
      else if (String.length model.password) <= 8 then
        ("red", "Passwords must be longer than 8 chars", Alert.danger)
      else if model.password /= model.passwordAgain then
        ("red", "Passwords do not match!", Alert.danger)
      else
        ("green", "OK", Alert.success)
  in
    div [ style [("color", color), ("font-family", "sans-serif")] ]
        -- [ text message
        [ alerttype [ text message ] ]