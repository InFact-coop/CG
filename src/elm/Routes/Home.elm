module Routes.Home exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)


home : Model -> Html Msg
home model =
    div [ class "tc center main vh-100 ma0" ]
        [ img [ class "center pt5 logo h5", src "./assets/png's/homepage_logo.png" ] []
        , h2 [ class "tc center brand f3" ] [ text "CREATE" ]
        , p [ class "tc center brand f3" ] [ text "gloucestershire" ]
        , section [ class "center ma0 mt2 pt5" ]
            [ a [ href "#previousOverview", class "link" ]
                [ img [ src "./assets/svg's_icons/see_conn.svg" ] []
                , p [] [ text "See interactions" ]
                ]
            , a [ href "#newContactDetails", class "link" ]
                [ img [ src "./assets/svg's_icons/add_new.svg" ] []
                , p [] [ text "Add new" ]
                ]
            ]
        ]
