module Routes.NewNotesPage exposing (..)

import Components.TitleBar exposing (..)
import DatePicker
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)


newNotesPage : Model -> Html Msg
newNotesPage model =
    let
        viewChoice =
            case model.notesPage of
                Choose ->
                    chooseView model

                Text ->
                    textView model

                Audio ->
                    audioView model
    in
    div [ class "blue center" ]
        [ titleBar "What happened?"
        , div [ class "tc" ]
            [ div [ class "tc" ]
                [ DatePicker.view
                    model.currentInteraction.interactionDate
                    DatePicker.defaultSettings
                    model.datePicker
                    |> Html.map SetDatePicker
                ]
            ]
        , viewChoice
        ]


chooseView : Model -> Html Msg
chooseView model =
    div []
        [ section [ class "flex justify-center pa2" ]
            [ button [ onClick <| ChangeNotes Audio, class "tc ma2 link dim dib f4" ]
                [ img [ src "./assets/svg_icons/record.svg" ] [] ]
            , button [ onClick <| ChangeNotes Text, class "tc ma2 link dim dib f4" ]
                [ img [ src "./assets/svg_icons/memo.svg" ] [] ]
            ]
        , section [ class "pa4 flex justify-center" ]
            [ button [ class "blue tc ma0 center brand bg-white h3 w5 b br1 b-orange f4", onClick <| ChangeNotes Choose ] [ text "Next" ]
            ]
        ]


audioView : Model -> Html Msg
audioView model =
    let
        ( audioSrc, exists ) =
            case model.currentInteraction.notes.audioUrl of
                "" ->
                    ( "", False )

                _ ->
                    ( model.currentInteraction.notes.audioUrl, True )

        audioHtml =
            if exists then
                div []
                    [ button [ id "play-button", class buttonClass, onClick <| PlayAudio True ] [ img [ src "./assets/svg_icons/hear_rec.svg" ] [] ]
                    , button [ class buttonClass, onClick ReRecord ] [ img [ src "./assets/png's/redo.png", class "h2 pb2" ] [] ]
                    ]
            else
                div []
                    [ button [ onClick StartRecording, class buttonClass, disabled model.isRecording ] [ img [ src "./assets/svg_icons/REC_BTN_start.svg" ] [] ]
                    , button [ onClick StopRecording, class buttonClass, disabled <| not model.isRecording ] [ img [ src "./assets/svg_icons/REC_BTN_stop.svg" ] [] ]
                    ]
    in
    div []
        [ div [ class "tc" ]
            [ audio [ controls False, class "", id "audio", src audioSrc ] []
            , img [ class "vh-25 mt4 mb3 pa3 br-100", classList [ ( "flash", model.isRecording ) ], src "./assets/svg_icons/RECORDING.svg" ] []
            , audioHtml
            ]
        , section [ class "pa4 flex justify-center" ]
            [ button [ onClick <| ChangeNotes Choose, class "tc ma2 link dim dib f4" ]
                [ img [ src "./assets/svg_icons/back.svg" ] [] ]
            ]
        ]


buttonClass =
    "dim b pointer w7 h3 f4 ma2"


textView : Model -> Html Msg
textView model =
    div []
        [ div [ class "pa3" ]
            [ textarea
                [ class "vh-25 w-100 input-reset pa3 f4 br3 b-orange listOfVisits"
                , onInput UpdateTextNote
                , value model.currentInteraction.notes.text
                , placeholder "Enter feedback here..."
                ]
                []
            ]
        , section [ class "flex justify-center pa2" ]
            [ button [ onClick <| ChangeNotes Text, class "tc ma2 link dim dib f4" ]
                [ img [ src "./assets/svg_icons/memo.svg" ] [] ]
            ]
        , section [ class "pa4 flex justify-center" ]
            [ button [ onClick <| ChangeNotes Choose, class "tc ma2 link dim dib f4" ]
                [ img [ src "./assets/svg_icons/back.svg" ] [] ]
            ]
        ]
