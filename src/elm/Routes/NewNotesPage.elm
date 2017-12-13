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
    in
    div []
        [ div [ class "tc" ] [ audio [ controls True, class "", id "audio", src audioSrc ] [] ]
        , div []
            [ button [ onClick StartAudio, class "" ] [ text "Begin recording" ]
            , button [ onClick StopAudio, class "" ] [ text "Finish recording" ]
            ]
        , section [ class "flex justify-center pa2" ]
            [ button [ onClick <| ChangeNotes Audio, class "tc ma2 link dim dib f4" ]
                [ img [ src "./assets/svg_icons/record.svg" ] [] ]
            ]
        , section [ class "pa4 flex justify-center" ]
            [ button [ onClick <| ChangeNotes Choose, class "tc ma2 link dim dib f4" ]
                [ img [ src "./assets/svg_icons/back.svg" ] [] ]
            ]
        ]



--audioMessagePage : Model -> Html Msg
--audioMessagePage model =
--    let
--        ( audioSrc, exists ) =
--            case model.currentInteraction.notes.audioUrl of
--                "" ->
--                    ( "", False )
--                _ ->
--                    ( model.currentInteraction.notes.audioUrl, True )
--        audioHtml =
--            if exists then
--                div []
--                    [ audio [ controls False, id "audio", src audioSrc ] []
--                    , button [ id "play-button", class buttonClass1, onClick <| PlayAudio True ] [ text "Listen Back" ]
--                    , button [ class buttonClass2, onClick ReRecord ] [ text "Record again" ]
--                    , a [ href "#stopVisitPage" ] [ button [ class "dim b pointer w7 h8 br1 f4 ma2  bg--bp white" ] [ text "Submit" ] ]
--                    ]
--            else
--                div []
--                    [ button [ onClick StartAudio, class buttonClass1, disabled model.isRecordingAudio ] [ text "Begin recording" ]
--                    , button [ onClick StopAudio, class buttonClass2, disabled <| not model.isRecordingAudio ] [ text "Finish recording" ]
--                    ]
--    in
--    div [ class "w-60-ns center tc" ]
--        [ div [ class "w-100 tl ma2 pa2" ] [ img [ class "h3", onClick GoBack, src "./assets/back_btn.svg" ] [] ]
--        , img [ class "vh-25 mt4 mb3 pa3 br-100", classList [ ( "flash", model.isRecordingAudio ) ], src "./assets/mic.svg" ] []
--        , audioHtml
--        ]
--buttonClass1 =
--    "dim b pointer b-orange br1 w7 h8 f4 ma2 bg-white brand"
--buttonClass2 =
--    "dim b pointer b-pink br1 w7 h8 f4 ma2 bg-white brand-pink"


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
