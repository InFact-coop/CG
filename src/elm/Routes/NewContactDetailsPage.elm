module Routes.NewContactDetailsPage exposing (..)

import Components.TitleBar exposing (..)
import DatePicker
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)


newContactDetailsPage : Model -> Html Msg
newContactDetailsPage model =
    div [ class "w-60-ns center" ]
        [ titleBar True "I just met"
        , formItem "assets/svg_icons/profile.svg" "Name" model.currentInteraction.name SetContactName
        , formItem "assets/svg_icons/email.svg" "Email" model.currentInteraction.email SetContactEmail
        , formItem "assets/svg_icons/phone.svg" "Phone" model.currentInteraction.phone SetContactPhone
        , formItem "assets/svg_icons/company.svg" "Organisation" model.currentInteraction.organisation SetContactOrganisation
        , div [ class "bb b--blue bw1 w-80 center flex items-center pb2 mb2" ]
            [ img [ src "assets/svg_icons/cal.svg", class "w2" ] []
            , div [ class "" ]
                [ DatePicker.view
                    model.currentInteraction.interactionDate
                    DatePicker.defaultSettings
                    model.datePicker
                    |> Html.map SetDatePicker
                ]
            ]
        , div [ class "w-80 center" ]
            [ p [ class "blue" ] [ text "Are you a member of Create Glost already?" ]
            , buttonItem model.currentInteraction.currentMember CurrentMemberYes "Yeah"
            , buttonItem model.currentInteraction.currentMember CurrentMemberNo "No, but I would love to sign up!"
            , p [ class "blue f4 tc w-80 center" ] [ text "Ok, save and continue to record a memo" ]
            , a [ href "#newNotes" ] [ img [ src "assets/svg_icons/go.svg", class "center db mb3" ] [] ]
            ]
        ]


formItem : String -> String -> String -> (String -> Msg) -> Html Msg
formItem imgSrc fieldName val msg =
    div []
        [ div [ class "bb b--blue bw1 w-80 center flex items-center pb2 mb2" ]
            [ img [ src imgSrc, class "h2 w2" ] []
            , input
                [ class "form-item__input ml2 dib f4 blue bn", onInput msg, value val, placeholder fieldName ]
                []
            ]
        ]


buttonItem : CurrentMemberOptions -> CurrentMemberOptions -> String -> Html Msg
buttonItem currentMemberUTFromModel buttonClicked textValue =
    div []
        [ button [ class "flex items-center bn bg-white", onClick (SetCurrentContact buttonClicked) ]
            [ div [ class "h2 w2 ba bw1 b--light-blue dib br1", classList [ ( "bg-light-blue", checkboxMember buttonClicked currentMemberUTFromModel ) ] ] []
            , p [ class "light-blue ml3 f5 dib ma0" ] [ text textValue ]
            ]
        ]


checkboxMember : CurrentMemberOptions -> CurrentMemberOptions -> Bool
checkboxMember buttonClicked currentMemberUTFromModel =
    buttonClicked == currentMemberUTFromModel
