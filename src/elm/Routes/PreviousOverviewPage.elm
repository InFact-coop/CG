module Routes.PreviousOverviewPage exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)


previousOverviewPage : Model -> Html Msg
previousOverviewPage model =
    div [ class "w-60-ns center" ]
        [ h1 [ class "tc f1" ] [ text "endroute" ]
        , p [ class "f3 w60 mh1 tc" ] [ text "endroute" ]
        ]
