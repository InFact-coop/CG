module Routes.PreviousOverviewPage exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)
import Components.TitleBar exposing (..)


previousOverviewPage : Model -> Html Msg
previousOverviewPage model =
    div [ class "w-60-ns center" ]
        [ titleBar "CG Interactions"
        , p [ class "blue center db tc" ] [ text "Search by name, tags or organisation" ]
        , input [ class "center db b-input pa2 ma2 w8", onInput SetSearchInput, value model.searchInput, placeholder "search" ] []
        , section
            [ class "center absolute imageInteractionItem" ]
            (interactionContent
                model
            )
        ]


interactionItem : Interaction -> Html Msg
interactionItem interaction =
    button [ class "w-100 interactionItem", onClick <| SelectInteractionItem interaction ]
        [ div [ class "" ]
            [ li [ class "db  bw2 b--blue-10" ]
                [ div [ class "bg-blue w3 h1 br3" ] [ p [ class "white" ] [ text interaction.tags ] ]
                , h1 [ class "f4 b blue f3" ] [ text interaction.organisation ]
                , p [ class "ma1 b blue f4" ] [ text interaction.name ]
                , div [ class "b blue" ] [ text interaction.notes.text ]
                , div [ class "ma2 flex justify-between pa2" ]
                    [ img [ src "./assets/svg_icons/email.svg", class "ma2" ] []
                    , img [ src "./assets/svg_icons/phone.svg", class "ma2" ] []
                    , img [ src "./assets/svg_icons/profile.svg", class "ma2" ] []
                    , img [ src "./assets/svg_icons/share.svg", class "ma2" ] []
                    ]
                ]
            ]
        ]


interactionContent : Model -> List (Html Msg)
interactionContent model =
    model.recordedInteractions
        |> List.filter (interactionContainsSearchInput model.searchInput)
        |> List.map interactionItem


interactionContainsSearchInput : String -> Interaction -> Bool
interactionContainsSearchInput searchInput interaction =
    List.any (containsSearchInput searchInput) <|
        [ interaction.name, interaction.organisation ]
            ++ [ interaction.tags ]


containsSearchInput : String -> String -> Bool
containsSearchInput searchInput string =
    String.contains (String.toLower searchInput) <| String.toLower string
