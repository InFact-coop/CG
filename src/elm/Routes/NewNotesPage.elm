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
    div [ class "w-60-ns center blue" ]
        [ div [ class "bg-record vh-100" ]
            [ titleBar True "What happened?"
            , div [ class "vh-50 mb3" ] [ viewChoice ]
            , section [ class "pa2 w-100" ]
                [ div [ class "w-100 flex justify-center" ]
                    [ button [ onClick <| ChangeNotes Audio, class "button-transparent" ]
                        [ img [ src "./assets/svg_icons/record.svg", class "br-100", classList [ ( "shadow-1", model.notesPage == Audio ) ] ] [] ]
                    , button [ onClick <| ChangeNotes Text, class "button-transparent" ]
                        [ img [ src "./assets/svg_icons/memo.svg", class "br-100", classList [ ( "shadow-1", model.notesPage == Text ) ] ] [] ]
                    ]
                , div [ class "w-100 flex items-center" ] [ a [ class "b-blue ba link blue tc ma0 mt2 pt2 center bg-white h3 b br3 f3 w-100", href "#newRecommend" ] [ text "Next" ] ]
                ]
            ]
        ]


chooseView : Model -> Html Msg
chooseView model =
    div []
        [ section [ class "center tc" ]
            [ div [ class "w-100" ] [ img [ class "vh-25 mt4 mb3 pa3 br-100", src "./assets/svg_icons/handshake_icn.svg" ] [] ]
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
        ]


buttonClass =
    "dim b pointer w7 h3 f4 ma2 button-transparent"


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
        ]


selectCat : Model -> Html Msg
selectCat model =
    select [ onInput UpdateTags, class "ba b--black pa2 f4 w-75 mh2" ]
        (List.map (catOption model) [ "Select Category", "Architecture", "Environment", "Health", "Community", "Craft", "Dance", "Design", "Education", "Film", "Heritage", "Literature", "Music", "New Media", "Theatre", "Visual Arts" ])


catOption : Model -> String -> Html Msg
catOption model category =
    option [ value category, selected <| category == model.currentInteraction.tags ] [ text category ]
