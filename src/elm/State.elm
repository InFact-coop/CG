module State exposing (..)

import Date
import DatePicker
import Navigation
import Subscriptions exposing (..)
import Task
import Types exposing (..)


-- MODEL


init : ( Model, Cmd Msg )
init =
    let
        ( datePicker, datePickerCmd ) =
            DatePicker.init
    in
    ( { route = NewNotesRoute
      , currentInteraction = Interaction Nothing "" "" "" "" (Notes "" "") [] [] Nothing
      , recordedInteractions = []
      , notesPage = Choose
      , isRecording = False
      , datePicker = datePicker
      }
    , Cmd.batch [ Task.perform ReceiveDate Date.now, Cmd.map SetDatePicker datePickerCmd ]
    )



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

        ChangeNotes view ->
            ( { model | notesPage = view }, Cmd.none )

        UpdateTextNote textNote ->
            let
                interaction =
                    model.currentInteraction

                notes =
                    model.currentInteraction.notes

                newNotes =
                    { notes | text = textNote }

                newInteraction =
                    { interaction | notes = newNotes }
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

        SetDatePicker msg ->
            let
                ( newDatePicker, datePickerCmd, dateEvent ) =
                    DatePicker.update DatePicker.defaultSettings msg model.datePicker

                date =
                    case dateEvent of
                        DatePicker.NoChange ->
                            model.currentInteraction.interactionDate

                        DatePicker.Changed newDate ->
                            newDate

                interaction =
                    model.currentInteraction

                newInteraction =
                    { interaction | interactionDate = date }
            in
            { model
                | currentInteraction = newInteraction
                , datePicker = newDatePicker
            }
                ! [ Cmd.map SetDatePicker datePickerCmd ]

        GoBack ->
            ( model, Navigation.back 1 )

        StartAudio ->
            ( model, recordStart () )

        StopAudio ->
            ( model, recordStop () )

        RecieveAudio audioUrl ->
            let
                interaction =
                    model.currentInteraction

                notes =
                    model.currentInteraction.notes

                newNotes =
                    { notes | audioUrl = audioUrl }

                newInteraction =
                    { interaction | notes = newNotes }
            in
            ( { model | currentInteraction = newInteraction }, Cmd.none )
