module View exposing (..)

import Html exposing (..)


-- My Elm Files

import Types exposing (..)
import Routes.Home exposing (..)
import Routes.NewDatePage exposing (..)
import Routes.NewContactPage exposing (..)
import Routes.NewNotesPage exposing (..)
import Routes.NewRecommendPage exposing (..)
import Routes.NewSharePage exposing (..)
import Routes.NewFollowUpPage exposing (..)
import Routes.NewAddToDBPage exposing (..)
import Routes.NewEndPage exposing (..)
import Routes.NotFoundPage exposing (..)
import Components.Navbar exposing (..)


view : Model -> Html Msg
view model =
    let
        page =
            case model.route of
                HomeRoute ->
                    home model

                NewDateRoute ->
                    newDatePage model

                NewContactRoute ->
                    newContactPage model

                NewNotesRoute ->
                    newNotesPage model

                NewRecommendRoute ->
                    newRecommendPage model

                NewShareRoute ->
                    newSharePage model

                NewFollowUpRoute ->
                    newFollowUpPage model

                NewAddToDBRoute ->
                    newAddToDBPage model

                NewEndRoute ->
                    newEndPage model

                NotFoundRoute ->
                    notFoundPage model
    in
        div []
            [ navbar model
            , page
            ]
