module Converters exposing (..)

import Soundex
import Roman


type alias Converter =
    { name : String
    , placeholder : String
    , inputFilter : String
    , filterCaseInsensitive : Bool
    , convertFunction : String -> String
    }


flippit : Converter
flippit =
    { name = "Flip"
    , placeholder = "Enter string to reverse"
    , inputFilter = ".+"
    , filterCaseInsensitive = False
    , convertFunction = String.reverse
    }


wibbleise : Converter
wibbleise =
    { name = "Wibbleise"
    , placeholder = "Enter string to wibbleise"
    , inputFilter = "[0-9]+"
    , filterCaseInsensitive = False
    , convertFunction = (\string -> string ++ " wibble")
    }


soundex : Converter
soundex =
    { name = "Soundex"
    , placeholder = "Enter name"
    , inputFilter = "[a-zA-Z]+"
    , filterCaseInsensitive = True
    , convertFunction = Soundex.toSoundex
    }


toArabic : Converter
toArabic =
    { name = "Roman to Arabic"
    , placeholder = "Enter Roman numeral string"
    , inputFilter = "^M{0,4}(CM|CD|D?C{0,3})(XC|XL|L?X{0,3})(IX|IV|V?I{0,3})$"
    , filterCaseInsensitive = True
    , convertFunction = Roman.romanToArabic
    }


toRoman : Converter
toRoman =
    { name = "Arabic to Roman"
    , placeholder = "Enter (Arabic) number"
    , inputFilter = "[0-9]+"
    , filterCaseInsensitive = False
    , convertFunction = Roman.arabicToRoman
    }
