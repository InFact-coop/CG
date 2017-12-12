module Routes.NewNotesPage exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Types exposing (..)


newNotesPage : Model -> Html Msg
newNotesPage model =
    div [ class "w-60-ns center" ]
        [ h1 [ class "tc f1" ] [ text "newNotesRoute" ]
        , p [ class "f3 w60 mh1 tc" ] [ text "newNotesRoute" ]
        ]
