module Soundex exposing (toSoundex)

import Helpers


encodeSoundexChar : Char -> Char
encodeSoundexChar char =
    let
        str =
            String.fromChar char
    in
        if String.contains str "bfpv" then
            '1'
        else if String.contains str "cgjkqsxz" then
            '2'
        else if String.contains str "dt" then
            '3'
        else if String.contains str "l" then
            '4'
        else if String.contains str "mn" then
            '5'
        else if String.contains str "r" then
            '6'
        else
            '0'


toSoundex : String -> String
toSoundex string =
    String.concat
        [ String.left 1 string
        , String.dropLeft 1 string
            |> String.map encodeSoundexChar
            |> String.split ""
            |> Helpers.compress
            |> String.join ""
            |> String.filter (\char -> char /= '0')
        ]
        |> String.padRight 4 '0'
        |> String.left 4
        |> String.toUpper
