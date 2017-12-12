module Routes.NewOrOldContactPage exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)


newOrOldContactPage : Model -> Html Msg
newOrOldContactPage model =
    div [ class "w-60-ns center" ]
        [ a [ href "#newCreateContact" ] [ button [ class "f3 w60 mh1 tc" ] [ text "Add New Contact" ] ]
        ]
