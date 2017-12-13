module Routes.NewRecommendPage exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)


newRecommendPage : Model -> Html Msg
newRecommendPage model =
    div [ class "w-60-ns center" ]
        [ h1 [ class "tc f1" ] [ text "Did you make any recommendations?" ]
        , button [ class "f3 w60 mh1 tc" ] [ text "Yes" ]
        , button [ class "f3 w60 mh1 tc" ] [ text "No" ]
        ]
