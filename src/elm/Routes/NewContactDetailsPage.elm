module Routes.NewContactDetailsPage exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)
import Components.TitleBar exposing (..)


newContactDetailsPage : Model -> Html Msg
newContactDetailsPage model =
    div [ class "w-60-ns center" ]
        [ titleBar "I just met"
        , h1 [ class "tc f1" ] [ text "newcontactRoute" ]
        , p [ class "f3 w60 mh1 tc" ] [ text "newCreateContactRoute" ]
        , formItem "Create Other Contact" model.currentInteraction.name SetContactName
        ]


formItem : String -> String -> (String -> Msg) -> Html Msg
formItem fieldName val msg =
    div []
        [ label [ class "dib fw4 w5 tr lh-copy f6 pr2" ] [ text fieldName ]
        , input
            [ class " w-80 measure ", onInput msg, value val ]
            []
        ]
