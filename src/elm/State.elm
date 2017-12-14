module State exposing (..)

import Navigation exposing (..)
import Date exposing (..)
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
        ( { route = HomeRoute
          , currentInteraction = Interaction Nothing "" "" "" "" (Notes "" "") "" [] Nothing
          , recordedInteractions = listRecordedInteractions
          , notesPage = Choose
          , isRecording = False
          , datePicker = datePicker
          , liveInteraction = Interaction Nothing "" "" "" "" (Notes "" "") "" [] Nothing
          , searchInput = ""
          }
        , Cmd.batch [ Task.perform ReceiveDate Date.now, Cmd.map SetDatePicker datePickerCmd ]
        )


listRecordedInteractions : List Interaction
listRecordedInteractions =
    [ Interaction Nothing "Alexa Vega" "PHS Limited" "alexavega@gmail.com" "+447598772611" (Notes "A grafitti artist from Stroud that is looking for work" "") "Artist" [] Nothing
    , Interaction Nothing "Daryl Sabara" "Cortez Ltd" "darylsabara@cortez.com" "+447532172611" (Notes "school teacher looking for a grafitti artist" "") "Event" [] Nothing
    , Interaction Nothing "Antonio Banderas" "Cargo S.L." "banderas@cargo.com" "+447598772987" (Notes "school teacher looking for a grafitti artist" "") "Event" [] Nothing
    , Interaction Nothing "Carla Gugino" "Organisation" "darylsabara@cortez.com" "+447532172611" (Notes "school teacher looking for a grafitti artist" "") "Event" [] Nothing
    , Interaction Nothing "Antonio Banderas" "Cargo S.L." "banderas@cargo.com" "+447598772987" (Notes "school teacher looking for a grafitti artist" "") "Event" [] Nothing
    ]



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

        SelectInteractionItem currentInteraction ->
            let
                command =
                    Navigation.newUrl "#previousDetail"
            in
                ( { model | liveInteraction = currentInteraction }, command )

        GoBack ->
            ( model, Navigation.back 1 )

        SetSearchInput input ->
            ( { model | searchInput = input }, Cmd.none )

        StartRecording ->
            ( { model | isRecording = True }, recordStart () )

        StopRecording ->
            ( { model | isRecording = False }, recordStop () )

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

        PlayAudio whichever ->
            ( model, playStart whichever )

        ReRecord ->
            let
                interaction =
                    model.currentInteraction

                notes =
                    model.currentInteraction.notes

                newNotes =
                    { notes | audioUrl = "" }

                newInteraction =
                    { interaction | notes = newNotes }
            in
                ( { model | currentInteraction = newInteraction }, Cmd.none )

        UpdateTags tag ->
            let
                interaction =
                    model.currentInteraction

                newInteraction =
                    { interaction | tags = tag }
            in
                ( { model | currentInteraction = newInteraction }, Cmd.none )
