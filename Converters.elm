module Converters exposing (..)

import Soundex
import Roman


type alias Converter =
    { name : String
    , placeholder : String
    , inputFilter : String
    , convertFunction : String -> String
    }


flippit : Converter
flippit =
    { name = "Flip"
    , placeholder = "Enter string to reverse"
    , inputFilter = ""
    , convertFunction = String.reverse
    }


wibbleise : Converter
wibbleise =
    { name = "Wibbleise"
    , placeholder = "Enter string to wibbleise"
    , inputFilter = "[0-9]+"
    , convertFunction = (\string -> string ++ " wibble")
    }


soundex : Converter
soundex =
    { name = "Soundex"
    , placeholder = "Enter name"
    , inputFilter = ""
    , convertFunction = Soundex.toSoundex
    }


toArabic : Converter
toArabic =
    { name = "Roman to Arabic"
    , placeholder = "Enter Roman numeral string"
    , inputFilter = ""
    , convertFunction = Roman.romanToArabic
    }


toRoman : Converter
toRoman =
    { name = "Arabic to Roman"
    , placeholder = "Enter (Arabic) number"
    , inputFilter = ""
    , convertFunction = Roman.arabicToRoman
    }
