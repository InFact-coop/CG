module Routes.PreviousDetailPage exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)


previousDetailPage : Model -> Html Msg
previousDetailPage model =
    div [ class "w-60-ns center" ]
        [ h1 [ class "tc f1" ] [ text "endroute" ]
        , p [ class "f3 w60 mh1 tc" ] [ text "endroute" ]
        ]
