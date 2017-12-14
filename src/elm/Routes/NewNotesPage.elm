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
        [ div [ class "bg-record vh-100" ]
            [ titleBar True "What happened?"
            , div [ class "vh-50 mb5" ] [ viewChoice ]
            ]
        ]


chooseView : Model -> Html Msg
chooseView model =
    div []
        [ section [ class "center tc" ]
            [ div [ class "w-100" ] [ img [ class "vh-25 mt4 mb3 pa3 br-100", src "./assets/svg_icons/handshake_icn.svg" ] [] ]
            , button [ onClick <| ChangeNotes Audio, class "tc ma2 link dim dib f4" ]
                [ img [ src "./assets/svg_icons/record.svg" ] [] ]
            , button [ onClick <| ChangeNotes Text, class "tc ma2 link dim dib f4" ]
                [ img [ src "./assets/svg_icons/memo.svg" ] [] ]
            ]
        , section [ class "pa4 flex justify-center" ]
            [ a [ class "b-blue ba link blue tc ma0 mt2 pt2 center bg-white h3 w-100 b br3 f3", href "#newRecommend" ] [ text "Next" ]
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
                    , button [ class buttonClass, onClick ReRecord ] [ img [ src "./assets/png/redo.png", class "h2 pb2" ] [] ]
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
            [ section [ class "flex justify-center pa2" ]
                [ img [ src "./assets/svg_icons/memo.svg" ] [] ]
            , textarea
                [ class "vh-25 w-100 input-reset pa3 f4 br3 b-orange listOfVisits"
                , onInput UpdateTextNote
                , value model.currentInteraction.notes.text
                , placeholder "Enter feedback here..."
                ]
                []
            ]
        , div [ class "tc" ] [ selectCat model ]
        , section [ class "pa4 flex justify-center" ]
            [ button [ onClick <| ChangeNotes Choose, class "tc ma2 link dim dib f4" ]
                [ img [ src "./assets/svg_icons/back.svg" ] [] ]
            ]
        ]


selectCat : Model -> Html Msg
selectCat model =
    select [ onInput UpdateTags, class "ba b--black pa2 f4 w-75 mh2" ]
        (List.map (catOption model) [ "Select Category", "Artist", "CGmember", "Event" ])


catOption : Model -> String -> Html Msg
catOption model category =
    option [ value category, selected <| category == model.currentInteraction.tags ] [ text category ]
