module Main exposing (..)

import Html exposing (Html, div, text, program, button, input, h1, img, br, ul, li, a)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Http
import Json.Decode as Decode
import Components.Foo exposing (myAdder)
import Random
import Regex

-- Continue tutorial at Effects/Time

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
    , termInput : String
    , termResult : List String
    }

init : (Model, Cmd Msg)
init =
  (Model "" "" "" "" 1 "Elm" [""], Cmd.none)


-- UPDATE
type Msg = Change String
    | Name String
    | Password String
    | PasswordAgain String
    | Roll
    | NewFace Int
    | SearchImages
    | NewSearchResult (Result Http.Error (List String))
    | ChangeTermInput String

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
            (model, Random.generate NewFace (Random.int 1 100))
        NewFace newFace ->
            --(Model "" "" "" "" newFace "" "", Cmd.none)
            ({ model | dieFace = newFace}, Cmd.none)
        SearchImages ->
            (model, getSearchResult model.termInput)
        NewSearchResult (Ok newResult) ->
            ( { model | termResult = newResult }, Cmd.none )
        NewSearchResult (Err _) ->
            (model, Cmd.none)
        ChangeTermInput term ->
            ({ model | termInput = term}, Cmd.none)

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
    [ a [ href "https://github.com/mdvanes/elmsta" ]
        [ img
            [ src "https://camo.githubusercontent.com/38ef81f8aca64bb9a64448d0d70f1308ef5341ab/68747470733a2f2f73332e616d617a6f6e6177732e636f6d2f6769746875622f726962626f6e732f666f726b6d655f72696768745f6461726b626c75655f3132313632312e706e67"
            , style[("position", "absolute"), ("top", "0"), ("right", "0"), ("border", "0")]
            , alt "Fork me on GitHub"
            , attribute "data-canonical-src" "https://s3.amazonaws.com/github/ribbons/forkme_right_darkblue_121621.png"
            ]
            []
        ]
    , input [placeholder "Elmsta", onInput Change] []
    , div [] [ text (String.reverse model.content) ]
    , input [ type_ "text", placeholder "Name", onInput Name ] []
    , input [ type_ "password", placeholder "Password", onInput Password ] []
    , input [ type_ "password", placeholder "Re-enter Password", onInput PasswordAgain ] []
    , viewValidation model
    , h1 [] [text (toString model.dieFace) ]
    , button [ onClick Roll ] [ text "Roll 100-sided dice" ]
    , h1 [ style[("font-family", "sans-serif")] ] [text (String.append "Searching " model.termInput)]
    , input [placeholder "Elmsta search term", onInput ChangeTermInput, value model.termInput] []
    , br [] []
    -- , img [src model.termResult] []
    -- , div [] [ text (String.join ";" model.termResult) ]
    , viewTermResultList model
    , br [] []
    , button [ onClick SearchImages ] [ text "Search Wiki" ]
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