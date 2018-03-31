module Roman exposing (..)

import Regex exposing (Regex)
import List.Extra as ListX


romanMap : List ( String, Int )
romanMap =
    [ ( "M", 1000 )
    , ( "CM", 900 )
    , ( "D", 500 )
    , ( "CD", 400 )
    , ( "C", 100 )
    , ( "XC", 90 )
    , ( "L", 50 )
    , ( "XL", 40 )
    , ( "X", 10 )
    , ( "IX", 9 )
    , ( "V", 5 )
    , ( "IV", 4 )
    , ( "I", 1 )
    ]


romanCharToInt : Char -> Int
romanCharToInt char =
    romanMap
        |> List.filter (Tuple.first >> (\x -> x == String.fromChar char))
        |> List.head
        |> Maybe.withDefault ( "N", 0 )
        |> Tuple.second


arabicToRoman : String -> String
arabicToRoman arabicString =
    case String.toInt arabicString of
        Err _ ->
            "Cannot convert this"

        Ok arabic ->
            if arabic >= 0 then
                case arabic of
                    0 ->
                        "N"

                    -- Adapted from https://billmill.org/roman.html
                    _ ->
                        let
                            next : Int -> Maybe ( String, Int )
                            next a =
                                romanMap
                                    |> List.filter
                                        (Tuple.second >> (\x -> x <= a))
                                    |> List.head
                                    |> Maybe.map (\( x, y ) -> ( x, a - y ))
                        in
                            arabic
                                |> ListX.unfoldr next
                                |> String.concat
            else
                "Cannot convert this"


romanToArabic : String -> String
romanToArabic romanString =
    let
        validRomanRE =
            Regex.regex
                "^M{0,4}(CM|CD|D?C{0,3})(XC|XL|L?X{0,3})(IX|IV|V?I{0,3})$"
                |> Regex.caseInsensitive

        sumArabic : List Int -> Int
        sumArabic ls =
            case ls of
                [] ->
                    0

                [ x ] ->
                    x

                x :: y :: zs ->
                    if x >= y then
                        x + sumArabic (y :: zs)
                    else
                        y - x + sumArabic zs
    in
        if Regex.contains validRomanRE romanString then
            romanString
                |> String.toUpper
                |> String.toList
                |> List.map romanCharToInt
                |> sumArabic
                |> toString
        else
            "Cannot convert this"
