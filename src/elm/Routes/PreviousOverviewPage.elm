module Routes.PreviousOverviewPage exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)


previousOverviewPage : Model -> Html Msg
previousOverviewPage model =
    div [ class "w-60-ns center" ]
        [ h2 [ class "center f3" ] [ text "CG Interactions" ]
        , p [] [ text "search by name, tags or organisation" ]
        , input [ class "pa2 ma2", onInput SetSearchInput, value model.searchInput ] []
        , section
            []
            (interactionContent
                model
            )
        ]


interactionItem : Interaction -> Html Msg
interactionItem interaction =
    button [ class "w-100", onClick <| SelectInteractionItem interaction ]
        [ div [ class "h4" ]
            [ li [ class "db bb bw2 b--black-10 ma4" ]
                [ h1 [] [ text interaction.organisation ]
                , p [ class "" ] [ text interaction.name ]
                , div [] [ text interaction.notes.text ]
                , div [ class "ma2" ]
                    [ img [ src "./assets/svg_icons/email.svg", class "" ] []
                    , img [ src "./assets/svg_icons/phone.svg", class "" ] []
                    , img [ src "./assets/svg_icons/profile.svg", class "" ] []
                    , img [ src "./assets/svg_icons/share.svg", class "" ] []
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
            ++ (List.map tagToString interaction.tags)


containsSearchInput : String -> String -> Bool
containsSearchInput searchInput string =
    String.contains (String.toLower searchInput) <| String.toLower string
