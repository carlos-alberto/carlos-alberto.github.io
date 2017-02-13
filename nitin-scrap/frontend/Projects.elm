module Projects exposing (Project(..), toString, allProjects, partTable, Part)

import Html exposing (Html, div, table, th, tr, td, thead, tbody, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)


toString : Project -> String
toString project =
    case project of
        P32S ->
            "P32S"

        X260 ->
            "X260"


allProjects : List Project
allProjects =
    [ P32S, X260 ]


type Project
    = P32S
    | X260


type alias Part =
    { id : String, description : String }


partTable : (Part -> msg) -> Project -> Html msg
partTable msg project =
    let
        parts =
            projectToParts project

        header =
            thead [] [ tr [] [ th [] [ text "P/N" ], th [] [ text "description" ] ] ]

        element part =
            tr [ onClick (msg part) ]
                [ td [] [ text part.id ]
                , td [] [ text part.description ]
                ]

        body =
            tbody [] (List.map element parts)
    in
        table [ class "table table-hover" ] [ header, body ]


projectToParts : Project -> List Part
projectToParts project =
    case project of
        P32S ->
            [ { id = "L0443943", description = "1RS BACK W/SIAB, LH" }
            , { id = "L0443944", description = "1RS BACK W/SIAB, RH" }
            , { id = "L0443945", description = "1RS BACK W/SIAB, LH, CLIMATE" }
            , { id = "L0443953", description = "1RS BACK W/SIAB, RH, CLIMATE" }
            , { id = "L0443955", description = "1RS CUSH" }
            , { id = "L0443956", description = "1RS CUSH, CLIMATE" }
            , { id = "L0446425", description = "3RS CUSH, LH" }
            , { id = "L0446426", description = "3RS CUSH, RH" }
            , { id = "L0446429", description = "3RS BACK, LH" }
            , { id = "L0446430", description = "3RS BACK, RH" }
            , { id = "L0452887", description = "1RS BACK W/SIAB, LH, NON BACKBOARD VARIANT" }
            , { id = "L0452888", description = "1RS BACK W/SIAB, RH, NON BACKBOARD VARIANT" }
            , { id = "L0452892", description = "1RS CUSH, NAS PASSENGER" }
            , { id = "L0452894", description = "1RS CUSH, CLIMATE NAS PASSENGER" }
            , { id = "L0455367", description = "2RS CUSH, 40% RH" }
            , { id = "L0455369", description = "2RS CUSH, 40% RH, CLIMATE" }
            , { id = "L0455371", description = "2RS CUSH, 60% LH" }
            , { id = "L0455374", description = "2RS CUSH, 60% LH, CLIMATE" }
            , { id = "L0455382", description = "2RS BACK, 40% RH, 7 SEAT" }
            , { id = "L0455386", description = "2RS BACK, 40% RH, 7 SEAT CLIMATE" }
            , { id = "L0455389", description = "2RS BACK, 60% LH, 7 SEAT" }
            , { id = "L0455390", description = "2RS BACK, 60% LH, 7 SEAT CLIMATE" }
            , { id = "L0455394", description = "2RS BACK, 20%, UPPER" }
            ]

        X260 ->
            [ { id = "L0419490", description = "2R Back 100% With Armrest" }
            , { id = "L0419491", description = "2R Back 40% RH" }
            , { id = "L0419492", description = "2R Back 40% LH" }
            , { id = "L0419493", description = "2R Cushion 100%" }
            , { id = "L0427672", description = "1R Back LH Standard (No Climate)" }
            , { id = "L0427673", description = "1R Back RH Standard (No Climate)" }
            , { id = "L0427674", description = "1R Back With Climate LH" }
            , { id = "L0427675", description = "1R Back With Climate RH" }
            , { id = "L0439488", description = "2R Rear RH Bolster (used with 40%)" }
            , { id = "L0439489", description = "2R Rear LH Bolster (used with 40%)" }
            , { id = "L0447791", description = "2R Back 100% Without Armrest" }
            , { id = "L0474725", description = "1R Cushion Comfort Climate" }
            , { id = "L0474726", description = "1R Cushion Front Cushion (Common) Extension Climate" }
            , { id = "L0474727", description = "1R Cushion Front Cushion (Common) Std Extension" }
            , { id = "L0474728", description = "1R Cushion Comfort" }
            , { id = "L0474729", description = "1R Back Front LH Squab LH Sport Climate" }
            , { id = "L0474730", description = "1R Back Front LH Squab LH Sport" }
            , { id = "L0474731", description = "1R Back Front RH Squab RH Sport Climate" }
            , { id = "L0474732", description = "1R Back Front RH Squab RH Sport" }
            , { id = "L0479674", description = "2R Back 20% Lower" }
            ]
