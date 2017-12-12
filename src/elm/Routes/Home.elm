module Routes.Home exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)


home : Model -> Html Msg
home model =
    div [ class "w-60-ns center" ]
        [ button [ class "f3 w60 mh1 tc" ] [ text "New Connection" ]
        , button [ class "f3 w60 mh1 tc" ] [ text "Previous Connections" ]
        ]
