module Hello exposing (..)

import Html exposing (text)

-- a named function "add"
add : Int -> Int -> Int
add x y =
  x + y

myList : List Float
myList = List.map sqrt [1, 25, 144, 625]

listString : String
listString = toString(myList)

-- a constant
myVar : String
--myVar = "Hello, " ++ toString(add 5 ((\x -> x + 1) 4))
myVar = 4
    |> (\x -> x + 1)
    |> add 5
    |> toString
    |> String.append ", "
    |> String.append listString
    |> String.append "Hello, " -- http://package.elm-lang.org/packages/elm-lang/core/latest/String

main =
    text myVar