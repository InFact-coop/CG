module Routes.NewCreateContactPage exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)


newCreateContactPage : Model -> Html Msg
newCreateContactPage model =
    div [ class "w-60-ns center" ]
        [ h1 [ class "tc f1" ] [ text "newcontactRoute" ]
        , p [ class "f3 w60 mh1 tc" ] [ text "newCreateContactRoute" ]
        ]
