module Routes.NewRecommendPage exposing (..)

import Components.TitleBar exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)


newRecommendPage : Model -> Html Msg
newRecommendPage model =
    let
        viewChoice =
            case model.detailsPage of
                ChooseDeets ->
                    div [] []

                Recommendations ->
                    recommendationsView model

                FollowUp ->
                    followUpView model

                Share ->
                    shareView model
    in
    div [ class "w-60-ns center" ]
        [ titleBar "Add some detail..."
        , chooseView model
        , viewChoice
        , section [ class "pa4 flex justify-center" ]
            [ a [ class "b-blue ba link blue tc ma0 mt2 pt2 center bg-white h3 w-100 b br3 f3", href "#newThankYou" ] [ text "Finished" ]
            ]
        ]


chooseView : Model -> Html Msg
chooseView model =
    section [ class "center ma0 pt3" ]
        [ div [ class "w-100 tc" ] [ buttonMaker "./assets/svg_icons/see_conn.svg" "Recommendations I made" Recommendations ]
        , div [ class "w-100 tc" ] [ buttonMaker "./assets/svg_icons/add_new.svg" "Set a follow up date" FollowUp, buttonMaker "./assets/svg_icons/calendar.svg" "Tell a CG team member about this" Share ]
        ]


buttonMaker : String -> String -> DetailsState -> Html Msg
buttonMaker imgSrc message newView =
    button [ class "link ma3", onClick <| ChangeDetails newView ]
        [ img [ src imgSrc ] []
        , p [] [ text message ]
        ]


recommendationsView : Model -> Html Msg
recommendationsView model =
    div [ class "fixed bottom-0 left-0 vh-100 w-100 pt5" ]
        [ div [ class "ba b--blue bw2 br3 bg-white-90 z-999 w-90 vh-75 pa0 ma0 center mt5 grow" ]
            [ button [ class "link ma2 relative top-0 left-0", onClick <| ChangeDetails ChooseDeets ]
                [ img [ src "./assets/svg_icons/remove.svg" ] []
                ]
            , div [ class "tc" ] [ text "recs" ]
            ]
        ]


followUpView : Model -> Html Msg
followUpView model =
    div [ class "fixed bottom-0 left-0 vh-100 w-100 pt5" ]
        [ div [ class "ba b--blue bw2 br3 bg-white-90 z-999 w-90 vh-75 pa0 ma0 center mt5 grow" ]
            [ button [ class "link ma2 relative top-0 left-0", onClick <| ChangeDetails ChooseDeets ]
                [ img [ src "./assets/svg_icons/remove.svg" ] []
                ]
            , div [ class "tc" ] [ text "follow" ]
            ]
        ]


shareView : Model -> Html Msg
shareView model =
    div [ class "fixed bottom-0 left-0 vh-100 w-100 pt5" ]
        [ div [ class "ba b--blue bw2 br3 bg-white-90 z-999 w-90 vh-75 pa0 ma0 center mt5 grow" ]
            [ button [ class "link ma2 relative top-0 left-0", onClick <| ChangeDetails ChooseDeets ]
                [ img [ src "./assets/svg_icons/remove.svg" ] []
                ]
            , div [ class "tc" ] [ text "share" ]
            ]
        ]
