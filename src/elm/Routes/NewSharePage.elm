module Routes.NewSharePage exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)


newSharePage : Model -> Html Msg
newSharePage model =
    div [ class "w-60-ns center" ]
        [ h1 [ class "tc f1" ] [ text "Do you want to share this with your contacts?" ]
        , p [ class "f3 w60 mh1 tc" ] [ text "newShareRoute." ]
        , input [ class "newShareRoute" ] []
        ]
