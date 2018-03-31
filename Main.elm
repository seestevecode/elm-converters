module Main exposing (main)

import Html exposing (Html)
import Html.Attributes as Attrib
import Html.Events as Events
import Converters exposing (Converter)
import Regex exposing (Regex)


allConverters : List Converter
allConverters =
    [ Converters.flippit
    , Converters.wibbleise
    , Converters.soundex
    , Converters.toRoman
    , Converters.toArabic
    ]


type alias Model =
    { converter : Converter
    , inputString : String
    , outputString : String
    }


type Msg
    = Choose Converter
    | Convert String
    | Clear


initModel : Model
initModel =
    { converter = Converters.flippit
    , inputString = ""
    , outputString = ""
    }


update : Msg -> Model -> Model
update msg model =
    case msg of
        Choose newConverter ->
            { model
                | converter = newConverter
                , inputString = ""
                , outputString = ""
            }

        Convert str ->
            { model
                | inputString = str
                , outputString =
                    let
                        validRE =
                            if model.converter.filterCaseInsensitive == True then
                                Regex.regex model.converter.inputFilter
                                    |> Regex.caseInsensitive
                            else
                                Regex.regex model.converter.inputFilter
                    in
                        if Regex.contains validRE model.inputString then
                            model.converter.convertFunction str
                        else
                            "Cannot convert this"
            }

        Clear ->
            { model
                | inputString = ""
                , outputString = ""
            }


radio : Converter -> Html Msg
radio converter =
    Html.label []
        [ Html.input
            [ Attrib.type_ "radio"
            , Attrib.name "converter"
            , Events.onClick (Choose converter)
            ]
            []
        , Html.text converter.name
        ]


view : Model -> Html Msg
view model =
    Html.div []
        [ Html.fieldset [] <| List.map radio allConverters
        , Html.input
            [ Attrib.placeholder model.converter.placeholder
            , Attrib.value model.inputString
            , Events.onInput Convert
            ]
            []
        , Html.button
            [ Events.onClick Clear ]
            [ Html.text "Clear" ]
        , Html.div []
            [ Html.text model.outputString ]
        ]


main : Program Never Model Msg
main =
    Html.beginnerProgram { model = initModel, update = update, view = view }
