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
                    div [ class "flex v-mid bb bw2 b--black-10" ] [ img [ class "ma3 br-100", src "./assets/svg's_icons/hear_rec.svg" ] [], audio [ class "mv3 pa3", controls True, id "audio", src audioUrl ] [] ]
    in
        div [ class "w-60-ns center brand tc" ]
            [ div [ class "w-100 tl pa2 flex bg-near-white bb b--black-10 v-mid" ] [ img [ class "pa3 h2", src "./assets/svg's_icons/see_conn.svg" ] [], h2 [ class "pl3" ] [ text model.liveInteraction.name ] ]
            , div [ class "w-100 tl ph4 pv0 ma0 flex b justify-between bg-near-white bb f6" ] [ p [ class "ph2 pv0" ] [ text "01/03/2018" ], p [ class "ph2 pv0" ] [] ]
            , interactionTextHtml
            , interactionAudioHtml
            ]
