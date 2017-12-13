module State exposing (..)

import Navigation exposing (..)
import Date exposing (..)
import Types exposing (..)


-- MODEL


initModel : Model
initModel =
    { route = HomeRoute
    , currentInteraction = Interaction "" "" "" "" (Notes "" "") [] [] Nothing
    , recordedInteractions = listRecordedInteractions
    , notesPage = Choose
    , isRecording = False
    , liveInteraction = Interaction "" "" "" "" (Notes "" "") [] [] Nothing
    }


listRecordedInteractions : List Interaction
listRecordedInteractions =
    [ Interaction "Alexa Vega" "PHS Limited" "alexavega@gmail.com" "+447598772611" (Notes "A grafitti artist from Stroud that is looking for work" "") [ Artist ] [] Nothing
    , Interaction "Daryl Sabara" "Cortez Ltd" "darylsabara@cortez.com" "+447532172611" (Notes "school teacher looking for a grafitti artist" "") [ Event ] [] Nothing
    , Interaction "Antonio Banderas" "Cargo S.L." "banderas@cargo.com" "+447598772987" (Notes "school teacher looking for a grafitti artist" "") [ Event ] [] Nothing
    , Interaction "Carla Gugino" "Organisation" "darylsabara@cortez.com" "+447532172611" (Notes "school teacher looking for a grafitti artist" "") [ Event ] [] Nothing
    , Interaction "Antonio Banderas" "Cargo S.L." "banderas@cargo.com" "+447598772987" (Notes "school teacher looking for a grafitti artist" "") [ Event ] [] Nothing
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

        SelectInteractionItem currentInteraction ->
            let
                command =
                    Navigation.newUrl "#previousDetail"
            in
                ( { model | liveInteraction = currentInteraction }, command )
