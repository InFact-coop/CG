module Routes.NewDatePage exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Types exposing (..)


newDatePage : Model -> Html Msg
newDatePage model =
    div [ class "w-60-ns center" ]
        [ h1 [ class "tc f1" ] [ text "newDateRoute" ]
        , p [ class "f3 w60 mh1 tc" ] [ text "newDateRoute" ]
        ]
