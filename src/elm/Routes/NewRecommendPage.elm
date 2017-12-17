module Routes.NewRecommendPage exposing (..)

import Components.TitleBar exposing (..)
import DatePicker exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)


newRecommendPage : Model -> Html Types.Msg
newRecommendPage model =
    let
        viewChoice =
            case model.detailsPage of
                ChooseDeets ->
                    div [] []

                Recommendations ->
                    viewMaker (recommendationsView model)

                FollowUp ->
                    viewMaker (followUpView model)

                Share ->
                    viewMaker (shareView model)
    in
    div [ class "w-60-ns center" ]
        [ div
            [ class "bg-record vh-100" ]
            [ titleBar True "Add some detail..."
            , chooseView
            , viewChoice
            , div [ class "pt3" ]
                [ button [ class "w-100 tc bn bg-white", onClick DataProtect ]
                    [ p [ class "ma0 pa0 light-blue f4 dib lh-copy ph2 v-mid" ] [ text "Send data protection email" ]
                    , div [ class "ma0 pa0 h1 w1 ba bw1 b--light-blue br1 dib v-mid", classList [ ( "bg-light-blue", model.dataProtect ) ] ] []
                    ]
                ]
            , section [ class "ph4 pb4 flex justify-center" ]
                [ a [ class "b-blue ba link blue tc ma0 mt2 pt2 center bg-white h3 w-100 b br3 f3", onClick AddInteraction ] [ text "Finished" ]
                ]
            ]
        ]


chooseView : Html Types.Msg
chooseView =
    section [ class "center ma0 pt3 vh-50 mb4" ]
        [ div [ class "w-100 tc mt2" ] [ buttonMaker "./assets/svg_icons/recommend.svg" "Recommendations I made" Recommendations ]
        , div [ class "w-100 mt3 tc" ]
            [ buttonMaker "./assets/svg_icons/calendar.svg" "Set a follow up date" FollowUp
            , buttonMaker "./assets/svg_icons/tell.svg" "Tell a CG team member" Share
            ]
        ]


buttonMaker : String -> String -> DetailsState -> Html Types.Msg
buttonMaker imgSrc message newView =
    button [ class "link button-transparent mh2 mb2", onClick <| ChangeDetails newView ]
        [ img [ src imgSrc ] []
        , p [ class "b blue" ] [ text message ]
        ]


viewMaker : Html Types.Msg -> Html Types.Msg
viewMaker filler =
    div [ class "fixed bottom-0 left-0 vh-100 w-100 pt5" ]
        [ div [ class "ba b--blue bw2 br3 bg-white z-999 w-90 vh-75 pa0 ma0 center mt5 grows transition-none " ]
            [ button [ class "button-transparent link ma2 relative top-0 left-0", onClick <| ChangeDetails ChooseDeets ]
                [ img [ src "./assets/svg_icons/remove.svg" ] []
                ]
            , filler
            ]
        ]


followUpView model =
    let
        settings =
            DatePicker.defaultSettings
    in
    div [ class "tc" ]
        [ p [ class "blue b f4" ] [ text "Set a date to follow up..." ]
        , div [ class "tc" ]
            [ DatePicker.view
                model.currentInteraction.followUpDate
                { settings
                    | placeholder = "Select Date"
                    , classNamespace = "f4 tc center elm-datepicker--"
                }
                model.datePicker
                |> Html.map SetDatePickerF
            ]
        , div [ class "pt6" ] [ button [ class "link white tc ma0 mt3 pt1 center bg-white h3 w-80 b bg-blue br3 f3", onClick <| ChangeDetails ChooseDeets ] [ text "Done" ] ]
        ]


shareView : Model -> Html Types.Msg
shareView model =
    div [ class "w-100 tc f4" ]
        [ p [ class "blue b" ] [ text "Share this interaction with..." ]
        , buttonItem model.shared1 Shared1 "Pippa"
        , buttonItem model.shared2 Shared2 "Caroline"
        , buttonItem model.shared3 Shared3 "Jay"
        , buttonItem model.shared4 Shared4 "Barney"
        , buttonItem model.shared5 Shared5 "Louise"
        , button [ class "link white tc ma0 mt3 pt1 center bg-white h3 w-80 b bg-blue br3 f3", onClick <| ChangeDetails ChooseDeets ] [ text "Share" ]
        ]


buttonItem : Bool -> Types.Msg -> String -> Html Types.Msg
buttonItem state msg textValue =
    div [ class "pa2" ]
        [ button [ class "w-50 tr bn bg-white", onClick msg ]
            [ p [ class "ma0 pa0 light-blue f5 dib lh-copy ph2 v-mid" ] [ text textValue ]
            , div [ class "ma0 pa0 h1 w1 ba bw1 b--light-blue br1 dib v-mid", classList [ ( "bg-light-blue", state ) ] ] []
            ]
        ]


recommendationsView : Model -> Html Types.Msg
recommendationsView { newRecommend } =
    div [ class "tc" ]
        [ div [ class "bb b--blue bw1 w-80 center pb2 mb5" ]
            [ img [ src "assets/svg_icons/profile.svg", class "h2 w2" ] []
            , label [ class "w-100 tr lh-copy light-blue f4 mh3" ] [ text "Name" ]
            , input
                [ class "w-100 f4 blue bn", onInput SetNewRecName, value newRecommend.name ]
                []
            ]
        , div [ class "bb b--blue bw1 w-80 center pb2 mb5" ]
            [ img [ src "assets/svg_icons/company.svg", class "h2 w2" ] []
            , label [ class "w-100 tr lh-copy light-blue f4 mh3" ] [ text "Organisation" ]
            , input
                [ class "w-100 f4 blue bn", onInput SetNewRecOrg, value newRecommend.organisation ]
                []
            ]
        , button [ class "b--blue ba link blue tc ma0 mt1 pt1 center bg-white h3 w-80 b bw2 b-blue br3 f3", onClick <| AddRecommendations newRecommend ] [ text "Add" ]
        ]
