module Routes.NewCreateContactPage exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)
import Dict


newCreateContactPage : Model -> Html Msg
newCreateContactPage model =
    div [ class "w-60-ns center" ]
        [ h1 [ class "tc f1" ] [ text "newcontactRoute" ]
        , p [ class "f3 w60 mh1 tc" ] [ text "newCreateContactRoute" ]
        , formItem model.fieldInputs "Create Contact" "createContact"
        , formItemBetter "Create Other Contact" model.contactInput SetContact
        ]


formItem : Dict.Dict String String -> String -> String -> Html Msg
formItem fieldInputs fieldName key =
    let
        val =
            fieldInputs
                |> Dict.get key
                |> Maybe.withDefault ""
    in
        div []
            [ label [ class "dib fw4 w5 tr lh-copy f6 pr2" ] [ text fieldName ]
            , input
                [ class " w-80 measure ", onInput (ChangeModelInput key), value val ]
                []
            ]


formItemBetter : String -> String -> (String -> Msg) -> Html Msg
formItemBetter fieldName val msg =
    div []
        [ label [ class "dib fw4 w5 tr lh-copy f6 pr2" ] [ text fieldName ]
        , input
            [ class " w-80 measure ", onInput msg, value val ]
            []
        ]
