module Routes.NewNotesPage exposing (..)

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
    div [ class "brand w-60-ns center" ]
        [ p [ class "tc f3 pa4" ] [ text "What happened?" ]
        , viewChoice
        ]


chooseView : Model -> Html Msg
chooseView model =
    div []
        [ section [ class "flex justify-center pa2" ]
            [ button [ onClick <| ChangeNotes Audio, class "tc ma2 link dim dib f4" ]
                [ img [ src "./assets/svg's_icons/record.svg" ] [] ]
            , button [ onClick <| ChangeNotes Text, class "tc ma2 link dim dib f4" ]
                [ img [ src "./assets/svg's_icons/memo.svg" ] [] ]
            ]
        , section [ class "pa4 flex justify-center" ]
            [ button [ class "tc ma0 center brand bg-white h3 w5 b br1 b-orange f4", onClick <| ChangeNotes Choose ] [ text "Next" ]
            ]
        ]


audioView : Model -> Html Msg
audioView model =
    div []
        [ section [ class "flex justify-center pa2" ]
            [ button [ onClick <| ChangeNotes Audio, class "tc ma2 link dim dib f4" ]
                [ img [ src "./assets/svg's_icons/record.svg" ] [] ]
            ]
        , section [ class "pa4 flex justify-center" ]
            [ button [ onClick <| ChangeNotes Choose, class "tc ma2 link dim dib f4" ]
                [ img [ src "./assets/svg's_icons/back.svg" ] [] ]
            ]
        ]


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
                [ img [ src "./assets/svg's_icons/memo.svg" ] [] ]
            ]
        , section [ class "pa4 flex justify-center" ]
            [ button [ onClick <| ChangeNotes Choose, class "tc ma2 link dim dib f4" ]
                [ img [ src "./assets/svg's_icons/back.svg" ] [] ]
            ]
        ]
