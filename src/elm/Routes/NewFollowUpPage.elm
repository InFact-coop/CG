module Routes.NewFollowUpPage exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)


newFollowUpPage : Model -> Html Msg
newFollowUpPage model =
    div [ class "w-60-ns center" ]
        [ h1 [ class "tc f1" ] [ text "newFollowUpRoute" ]
        , p [ class "f3 w60 mh1 tc" ] [ text "newFollowUpRoute" ]
        ]
