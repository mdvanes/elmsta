module Main exposing (..)

import Html exposing (Html, div, text, program, button, input, h1, img, br)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Http
import Json.Decode as Decode
import Components.Foo exposing (myAdder)
import Random
import Regex


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
    , termResult : String
    }

init : (Model, Cmd Msg)
init =
  (Model "" "" "" "" 1 "cats" "waiting.gif", Cmd.none)


-- UPDATE
type Msg = Change String
    | Name String
    | Password String
    | PasswordAgain String
    | Roll
    | NewFace Int
    | SearchImages
    | NewSearchResult (Result Http.Error String)
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
            "https://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=" ++ term
        request =
            Http.get url decodeGifUrl
    in
        Http.send NewSearchResult request

decodeGifUrl : Decode.Decoder String
decodeGifUrl =
    Decode.at ["data", "image_url"] Decode.string

-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

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
    , h1 [] [text (toString model.dieFace) ]
    , button [ onClick Roll ] [ text "Roll 100-sided dice" ]
    , h1 [] [text (String.append "Searching " model.termInput)]
    , input [placeholder "Elmsta search term", onInput ChangeTermInput, value model.termInput] []
    , br [] []
    , img [src model.termResult] []
    , br [] []
    , button [ onClick SearchImages ] [ text "Search Images" ]
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