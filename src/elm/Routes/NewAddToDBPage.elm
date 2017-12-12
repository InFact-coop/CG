module Routes.NewAddToDBPage exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)


newAddToDBPage : Model -> Html Msg
newAddToDBPage model =
    div [ class "w-60-ns center" ]
        [ h1 [ class "tc f1" ] [ text "dbroute" ]
        , p [ class "f3 w60 mh1 tc" ] [ text "newdbroute" ]
        ]
