module Routes.NewDatePage exposing (..)

import Date exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Types exposing (..)


newDatePage : Model -> Html Msg
newDatePage model =
    div [ class "w-60-ns center" ]
        [ h1 [ class "tc f1" ] [ text "When did you make this connection?" ]
        , input [] [ text "" ]
        , p [ class "f3 w60 mh1 tc" ] [ text "Is this connection in our database?" ]
        , button [] [ text "Yes" ]
        , button [] [ text "No" ]
        ]
