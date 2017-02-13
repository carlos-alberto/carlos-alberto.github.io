module Main exposing (main)

import Html exposing (Html, div, text, button, table, thead, tbody, tr, td, th, span, ul, li, a)
import Html.Attributes exposing (class)
import Html.Attributes.Aria exposing (role)
import Html.Events exposing (onClick)
import Http
import Json.Decode exposing (list, string)
import FaultSelector exposing (faultSelectorView)
import Projects


init : ( Model, Cmd Msg )
init =
    let
        model =
            { toolAndReason = Nothing, currentPage = ProjectSelector, project = Projects.P32S, part = Nothing }
    in
        ( model, Cmd.none )


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        , init = init
        }


type alias ToolAndReason =
    { tool : Int, reason : String }


type Page
    = ProjectSelector
    | FaultSelector


type alias Model =
    { toolAndReason : Maybe ToolAndReason
    , currentPage : Page
    , project : Projects.Project
    , part : Maybe Projects.Part
    }


type Msg
    = ReasonClick Int String
    | ProjectClick Projects.Project
    | PartClick Projects.Part


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ReasonClick tool reason ->
            let
                info =
                    { tool = tool, reason = reason }
            in
                ( { model | toolAndReason = Just info }, Cmd.none )

        ProjectClick project ->
            ( { model | project = project }, Cmd.none )

        PartClick part ->
            ( { model | part = Just part, currentPage = FaultSelector }, Cmd.none )


partSelectorView : Projects.Project -> Html Msg
partSelectorView project =
    div [ class "table-responsive" ]
        [ Projects.partTable PartClick project ]


projectSelectorView : Model -> Html Msg
projectSelectorView model =
    let
        class_ project =
            if project == model.project then
                "active"
            else
                ""

        makeElement project =
            li [ role "presentation", class (class_ project) ]
                [ a [ onClick (ProjectClick project) ] [ text (Projects.toString project) ]
                ]

        elements =
            List.map makeElement Projects.allProjects
    in
        div [] [ ul [ class "nav nav-tabs" ] elements, partSelectorView model.project ]


view : Model -> Html Msg
view model =
    let
        blah =
            case model.currentPage of
                ProjectSelector ->
                    projectSelectorView model

                FaultSelector ->
                    faultSelectorView ReasonClick
    in
        div [] [ blah, currentStateView model ]


currentStateView : Model -> Html Msg
currentStateView model =
    let
        project =
            "Selected Project: " ++ (Projects.toString model.project)

        part =
            case model.part of
                Nothing ->
                    "Selected Part: None"

                Just x ->
                    "Selected Part: " ++ x.description ++ " (" ++ x.id ++ ")"

        tool =
            case model.toolAndReason of
                Nothing ->
                    "Selected Tool: None"

                Just x ->
                    "Selected Tool: " ++ toString x.tool

        reason =
            case model.toolAndReason of
                Nothing ->
                    "Selected Reason: None"

                Just x ->
                    "Selected Reason: " ++ x.reason
    in
        ul [] (List.map (\x -> li [] [ text x ]) [ project, part, tool, reason ])


createLog : Http.Request (List String)
createLog =
    let
        body =
            Http.jsonBody
    in
        Http.post "/log" body
