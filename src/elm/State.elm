module State exposing (..)

import Types exposing (..)
import Navigation


-- MODEL


initModel : Model
initModel =
    { route = HomeRoute
    , currentInteraction = Interaction "" "" "" "" (Notes "" "") [] [] Nothing CurrentMemberNotSet
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

        SetContactEmail input ->
            let
                interaction =
                    model.currentInteraction

                newInteraction =
                    { interaction | email = input }
            in
                ( { model | currentInteraction = newInteraction }, Cmd.none )

        SetContactPhone input ->
            let
                interaction =
                    model.currentInteraction

                newInteraction =
                    { interaction | phone = input }
            in
                ( { model | currentInteraction = newInteraction }, Cmd.none )

        SetContactOrganisation input ->
            let
                interaction =
                    model.currentInteraction

                newInteraction =
                    { interaction | organisation = input }
            in
                ( { model | currentInteraction = newInteraction }, Cmd.none )

        GoBack ->
            ( model, Navigation.back 1 )

        SetCurrentContact yesOrNo ->
            case yesOrNo of
                CurrentMemberYes ->
                    let
                        interaction =
                            model.currentInteraction

                        newInteraction =
                            { interaction | currentMember = CurrentMemberYes }
                    in
                        ( { model | currentInteraction = newInteraction }, Cmd.none )

                CurrentMemberNo ->
                    let
                        interaction =
                            model.currentInteraction

                        newInteraction =
                            { interaction | currentMember = CurrentMemberNo }
                    in
                        ( { model | currentInteraction = newInteraction }, Cmd.none )

                _ ->
                    ( model, Cmd.none )
