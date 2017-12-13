module State exposing (..)

import Types exposing (..)
import Date
import Task


-- MODEL


initModel : Model
initModel =
    { route = HomeRoute
    , currentInteraction = Interaction Nothing "" "" "" "" (Notes "" "") [] [] Nothing
    , recordedInteractions = []
    , notesPage = Choose
    , isRecording = False
    }



--initRecordedContacts : List Contact
--initRecordedContacts =
--    [ Contact 1 "Alexa Vega" "PHS Limited" "alexavega@gmail.com" 7598772611 [ 1 ]
--    , Contact 2 "Daryl Sabara" "Cortez Ltd" "darylsabara@cortez.com" 7532172611 [ 2 ]
--    , Contact 3 "Antonio Banderas" "Cargo S.L." "banderas@cargo.com" 7598772987 [ 1 ]
--    , Contact 4 "Carla Gugino" "Organisation" "darylsabara@cortez.com" 7532172611 [ 2 ]
--    , Contact 5 "Antonio Banderas" "Cargo S.L." "banderas@cargo.com" 7598772987 [ 1 ]
--    ]
--UPDATE


getRoute : String -> Route
getRoute hash =
    case hash of
        "" ->
            HomeRoute

        "#newContactDetails" ->
            NewContactDetailsRoute

        "#newNotes" ->
            NewNotesRoute

        "#newRecommend" ->
            NewRecommendRoute

        "#newShare" ->
            NewShareRoute

        "#newThankYou" ->
            NewThankYouRoute

        "#previousOverview" ->
            PreviousInteractionsOverviewRoute

        "#previousDetail" ->
            PreviousInteractionsDetailRoute

        _ ->
            NotFoundRoute


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UrlChange location ->
            ( { model | route = getRoute location.hash }, Cmd.none )

        SetContactName input ->
            let
                interaction =
                    model.currentInteraction

                newInteraction =
                    { interaction | name = input }
            in
                ( { model | currentInteraction = newInteraction }, Cmd.none )

        RequestDate ->
            ( model, Task.perform ReceiveDate Date.now )

        ReceiveDate date ->
            let
                interaction =
                    model.currentInteraction

                newInteraction =
                    { interaction | interactionDate = Just date }
            in
                ( { model | currentInteraction = newInteraction }, Cmd.none )
