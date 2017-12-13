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
                        [ img [ class "ma3", src "./assets/svg's_icons/memo.svg" ] []
                        , p [ class "gray" ] [ text intText ]
                        ]

        interactionAudioHtml =
            case model.liveInteraction.notes.audioUrl of
                audioUrl ->
                    audio [ class " mv3 pa3", controls True, id "audio", src audioUrl ] []
    in
        div [ class "w-60-ns center brand tc" ]
            [ div [ class "w-100 tl pa2 bg-near-white bb b--black-10 v-mid" ]
                [ img [ class "pa3 h2", src "./assets/png's/icon.png" ] []
                , h2 [ class "pl3" ] [ text model.liveInteraction.name ]
                ]
            , div [ class "interactionDetailsImage" ]
                [ img [ class "ma3 br-100", src "./assets/svg's_icons/hear_rec.svg" ] [ interactionAudioHtml ]
                , img [] []
                , img [] []
                , img [] []
                ]
            , div [ class "w-100 bb" ]
                [ h3 [] [ text "Date and time" ]
                , p [ class "ph2 pv0" ] [ text "Met on Aug 3rd, 2017 at 6pm" ]
                , p [ class "ph2 pv0" ] [ text "at New Town Hall, GL8 9JDF" ]
                ]
            , interactionAudioHtml
            , div []
                [ h3 [] [ text "Notes" ]
                , interactionTextHtml
                ]
            ]
