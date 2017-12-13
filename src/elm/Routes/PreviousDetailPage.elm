module Routes.PreviousDetailPage exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)


previousDetailPage : Model -> Html Msg
previousDetailPage model =
    let
        interactionTextHtml =
            case model.liveInteraction.notes.text of
                intText ->
                    div
                        [ class "flex v-mid bb bw2 b--black-10" ]
                        [ img [ class "ma3", src "./assets/svg_icons/memo.svg" ] []
                        , p [ class "gray" ] [ text intText ]
                        ]

        interactionAudioHtml =
            case model.liveInteraction.notes.audioUrl of
                audioUrl ->
                    audio [ class " mv3 pa3", controls True, id "audio", src audioUrl ] []
    in
        div [ class "interactionDetailsImage w-100 center brand tc" ]
            [ div [ class "w-100 tl pa2 bg-near-white bb b--black-10 v-mid" ]
                [ a [ href "#" ] [ img [ class "pa3 h2", src "./assets/png's/icon.png" ] [] ]
                , h2 [ class "pl3" ] [ text model.liveInteraction.name ]
                ]
            , div [ class "w-100 center ma0 pa0" ]
                [ div [ class "inline-flex flex-wrap" ]
                    [ img [ class "ma3 br-100", src "./assets/svg_icons/hear_rec.svg" ] [ interactionAudioHtml ]
                    , img [ class "ma3", src "./assets/svg_icons/man.svg" ] []
                    , img [ class "ma3 br-100", src "./assets/svg_icons/share_profile_page.svg" ] []
                    ]
                , div [ class "center ma0 pa0" ] [ img [ class "ma3 br-100", src "./assets/svg_icons/cal.svg" ] [] ]
                ]
            , interactionAudioHtml
            , div [ class "bb bg-blue" ]
                [ div [ class "white" ]
                    [ h3 [ class "pt2" ] [ text "Date and time" ]
                    , p [ class "ph2 pv0" ] [ text "Met on Aug 3rd, 2017 at 6pm" ]
                    , p [ class "ph2 pv0" ] [ text "at New Town Hall, GL8 9JDF" ]
                    ]
                , div [ class "bg-white" ]
                    [ h3 [ class "center pt3" ] [ text "Notes" ]
                    , interactionTextHtml
                    ]
                ]
            ]
