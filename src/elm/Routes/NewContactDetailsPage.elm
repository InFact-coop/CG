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
        , formItem "assets/svg_icons/profile.svg" "Name" model.currentInteraction.name SetContactName
        , formItem "assets/svg_icons/email.svg" "Email" model.currentInteraction.email SetContactEmail
        , formItem "assets/svg_icons/phone.svg" "Phone" model.currentInteraction.phone SetContactPhone
        , formItem "assets/svg_icons/company.svg" "Organisation" model.currentInteraction.organisation SetContactOrganisation
        ]


formItem : String -> String -> String -> (String -> Msg) -> Html Msg
formItem imgSrc fieldName val msg =
    div []
        [ div [ class "bb b--blue bw1 w-80 center flex items-center pb2 mb5" ]
            [ img [ src imgSrc, class "h2 w2" ] []
            , label [ class "dib tr lh-copy light-blue f4 mh3" ] [ text fieldName ]
            , input
                [ class " dib f4 blue bn", onInput msg, value val ]
                []
            ]
        ]
