module Components.TitleBar exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)


-- import Types exposing (..)


titleBar : String -> Html Msg
titleBar title =
    div [ class "db ma0 bg-white blue w-100 pa2" ]
        [ button [ onClick GoBack, class "dib background-back h3 w3 bg-white bn" ] []
        , h1 [ class "ml4 dib" ] [ text title ]
        ]
