module Helpers exposing (..)


compress : List a -> List a
compress list =
    case list of
        [] ->
            []

        [ x ] ->
            [ x ]

        x :: y :: zs ->
            if x == y then
                compress (y :: zs)
            else
                x :: compress (y :: zs)
