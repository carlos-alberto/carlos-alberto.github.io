module FaultSelector exposing (faultSelectorView)

import Html exposing (Html, div, text, button, table, thead, tbody, tr, td, th, span, ul, li, a)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)


makeHeaderRow : Html msg
makeHeaderRow =
    thead [] [ tr [] ([ th [] [ text "Tool Number" ] ] ++ List.map (\x -> th [] [ text x ]) scrapReasons) ]


makeRow : (Int -> String -> msg) -> Int -> Html msg
makeRow msg i =
    tr []
        ([ td [] [ text <| toString i ] ]
            ++ List.map (\x -> td [ onClick (msg i x) ] []) scrapReasons
        )


makeTable : (Int -> String -> msg) -> Html msg
makeTable msg =
    div [ class "table-responsive" ]
        [ table [ class "table table-bordered" ]
            [ makeHeaderRow
            , tbody []
                (List.map (makeRow msg) (List.range 1 12))
            ]
        ]


faultSelectorView : (Int -> String -> msg) -> Html msg
faultSelectorView msg =
    div [] [ makeTable msg ]


scrapReasons : List String
scrapReasons =
    [ "Process"
    , "Vents"
    , "Missing Wires"
    , "Missing Hook & Loops"
    , "Misplaced Wires"
    , "Cold Mould"
    , "Overspray"
    , "Blistering Temp"
    , "Voids 'A' Surface"
    , "Voids 'B' Surface"
    , "E Stop"
    , "Machine Fault"
    , "Torn"
    , "Fanfare/Malatex Missing"
    , "Quality Dept Scrap"
    , "White Rabbit"
    , "Packaging Damage"
    , "Development"
    ]
