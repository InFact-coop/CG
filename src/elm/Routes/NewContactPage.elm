module Routes.NewContactPage exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)


newContactPage : Model -> Html Msg
newContactPage model =
    div [ class "w-60-ns center" ]
        [ h1 [ class "tc f1" ] [ text "newcontactRoute" ]
        , p [ class "f3 w60 mh1 tc" ] [ text "newcontactRoute" ]
        ]
