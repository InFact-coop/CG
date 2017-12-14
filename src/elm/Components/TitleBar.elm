module Components.TitleBar exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)


-- import Types exposing (..)


titleBar : Bool -> String -> Html Msg
titleBar bool title =
    let
        backButton =
            case bool of
                True ->
                    button [ onClick GoBack, class "background-back h3 w3 bg-white bn absolute left-0" ] []

                False ->
                    div [] []
    in
        div [ class "db ma0 bg-white blue w-100 pa2 flex justify-center items-center relative" ]
            [ backButton
            , h1 [ class "" ] [ text title ]
            ]
