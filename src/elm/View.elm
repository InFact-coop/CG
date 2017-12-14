module View exposing (..)

-- My Elm Files

import Components.Navbar exposing (..)
import Html exposing (..)
import Routes.Home exposing (..)
import Routes.NewContactDetailsPage exposing (..)
import Routes.NewNotesPage exposing (..)
import Routes.NewRecommendPage exposing (..)
import Routes.NewSharePage exposing (..)
import Routes.NewThankYouPage exposing (..)
import Routes.NotFoundPage exposing (..)
import Routes.PreviousDetailPage exposing (..)
import Routes.PreviousOverviewPage exposing (..)
import Types exposing (..)


view : Model -> Html Msg
view model =
    let
        page =
            case model.route of
                HomeRoute ->
                    home model

                NewContactDetailsRoute ->
                    newContactDetailsPage model

                NewNotesRoute ->
                    newNotesPage model

                NewRecommendRoute ->
                    newRecommendPage model

                NewShareRoute ->
                    newSharePage model

                NewThankYouRoute ->
                    newThankYouPage model

                PreviousInteractionsOverviewRoute ->
                    previousOverviewPage model

                PreviousInteractionsDetailRoute ->
                    previousDetailPage model

                NotFoundRoute ->
                    notFoundPage model
    in
        div []
            [ page ]
