module State exposing (..)

import Date exposing (..)
import DatePicker
import Navigation exposing (..)
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
      , currentInteraction = Interaction Nothing "" "" "" "" (Notes "" "") "" [] Nothing CurrentMemberNotSet ""
      , recordedInteractions = listRecordedInteractions
      , notesPage = Choose
      , isRecording = False
      , datePicker = datePicker
      , liveInteraction = Interaction Nothing "" "" "" "" (Notes "" "") "" [] Nothing CurrentMemberNotSet ""
      , searchInput = ""
      , detailsPage = ChooseDeets
      , newRecommend = Recommendation "" ""
      , shared1 = False
      , shared2 = False
      , shared3 = False
      , shared4 = False
      , shared5 = False
      , dataProtect = False
      }
    , Cmd.batch [ Task.perform ReceiveDate Date.now, Cmd.map SetDatePicker datePickerCmd ]
    )


listRecordedInteractions : List Interaction
listRecordedInteractions =
    [ Interaction (makeDate "12/12/2017") "Alexa Vega" "PHS Limited" "alexavega@gmail.com" "+447598772611" (Notes "A grafitti artist from Stroud that is looking for work" "") "Artist" [ Recommendation "Lucy" "TBSA ltd", Recommendation "Rebe" "NHS" ] (makeDate "12/21/2017") CurrentMemberNotSet "Farmers Market"
    , Interaction (makeDate "11/28/2017") "Daryl Sabara" "Cortez Ltd" "darylsabara@cortez.com" "+447532172611" (Notes "school teacher looking for a grafitti artist" "") "Fine Arts" [ Recommendation "Mavis" "Monzo", Recommendation "Ronan" "AirBnb" ] (makeDate "12/19/2017") CurrentMemberNotSet "Farmers Market"
    , Interaction (makeDate "11/19/2017") "Antonio Banderas" "Cargo S.L." "banderas@cargo.com" "+447598772987" (Notes "school teacher looking for a grafitti artist" "") "Event" [ Recommendation "Max" "Uber Eats", Recommendation "Zooey" "Queen" ] (makeDate "12/01/2017") CurrentMemberNotSet "Farmers Market"
    , Interaction (makeDate "11/12/2017") "Carla Gugino" "Organisation" "darylsabara@cortez.com" "+447532172611" (Notes "school teacher looking for a grafitti artist" "") "Community" [ Recommendation "Jen" "Tate Modern", Recommendation "Ellie" "Deliveroo" ] (makeDate "11/18/2017") CurrentMemberNotSet "Farmers Market"
    , Interaction (makeDate "10/01/2017") "Antonio Banderas" "Cargo S.L." "banderas@cargo.com" "+447598772987" (Notes "school teacher looking for a grafitti artist" "") "New Media" [ Recommendation "Dan" "Olympics ltd", Recommendation "Ash" "British Council" ] (makeDate "10/29/2017") CurrentMemberNotSet "Farmers Market"
    ]


makeDate : String -> Maybe Date
makeDate string =
    Result.toMaybe (Date.fromString string)



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

        SetContactWhere input ->
            let
                interaction =
                    model.currentInteraction

                newInteraction =
                    { interaction | event = input }
            in
            ( { model | currentInteraction = newInteraction }, Cmd.none )

        GoBack ->
            ( model, Navigation.back 1 )

        SetSearchInput input ->
            ( { model | searchInput = input }, Cmd.none )

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

        ChangeDetails view ->
            ( { model | detailsPage = view }, Cmd.none )

        SetNewRecName name ->
            ( { model
                | newRecommend =
                    model.newRecommend
                        |> (\nr -> { nr | name = name })
              }
            , Cmd.none
            )

        SetNewRecOrg organisation ->
            ( { model
                | newRecommend =
                    model.newRecommend
                        |> (\nr -> { nr | organisation = organisation })
              }
            , Cmd.none
            )

        AddRecommendations reccomendation ->
            ( { model
                | currentInteraction =
                    model.currentInteraction
                        |> (\ci -> { ci | recommendations = reccomendation :: ci.recommendations })
                , detailsPage = ChooseDeets
              }
            , Cmd.none
            )

        Shared1 ->
            ( { model | shared1 = not model.shared1 }, Cmd.none )

        Shared2 ->
            ( { model | shared2 = not model.shared2 }, Cmd.none )

        Shared3 ->
            ( { model | shared3 = not model.shared3 }, Cmd.none )

        Shared4 ->
            ( { model | shared4 = not model.shared4 }, Cmd.none )

        Shared5 ->
            ( { model | shared5 = not model.shared5 }, Cmd.none )

        SetDatePickerF msg ->
            let
                ( newDatePicker, datePickerCmd, dateEvent ) =
                    DatePicker.update DatePicker.defaultSettings msg model.datePicker

                date =
                    case dateEvent of
                        DatePicker.NoChange ->
                            model.currentInteraction.followUpDate

                        DatePicker.Changed newDate ->
                            newDate

                interaction =
                    model.currentInteraction

                newInteraction =
                    { interaction | followUpDate = date }
            in
            { model
                | currentInteraction = newInteraction
                , datePicker = newDatePicker
            }
                ! [ Cmd.map SetDatePickerF datePickerCmd ]

        AddInteraction ->
            let
                command =
                    Navigation.newUrl "#previousDetail"

                resetInt =
                    Interaction Nothing "" "" "" "" (Notes "" "") "" [] Nothing CurrentMemberNotSet ""

                updateList =
                    model.currentInteraction :: model.recordedInteractions
            in
            ( { model | recordedInteractions = updateList, liveInteraction = model.currentInteraction, currentInteraction = resetInt }, command )

        DataProtect ->
            ( { model | dataProtect = not model.dataProtect }, Cmd.none )
