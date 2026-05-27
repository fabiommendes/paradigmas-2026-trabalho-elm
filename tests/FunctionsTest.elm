module FunctionsTest exposing (tests)

import Expect exposing (FloatingPointTolerance(..))
import Functions
    exposing
        ( argMax
        , func
        , partition
        )
import Test exposing (..)


bigNumber : Int
bigNumber =
    1501353



-- 1723519


tests : Test
tests =
    describe "Functions"
        [ describe "func"
            [ test "Calcula a função recursiva corretamente" <|
                \_ ->
                    Expect.all
                        [ \_ -> func 0 |> Expect.within (Absolute 0.0001) 0
                        , \_ -> func 1 |> Expect.within (Relative 1.0e-9) 1
                        , \_ -> func 2 |> Expect.within (Relative 1.0e-9) 1.5
                        , \_ -> func 3 |> Expect.within (Relative 1.0e-9) (1.5 + 1 / 3)
                        ]
                        ()
            , test "Calcula para números grandes sem estourar a pilha" <|
                \_ ->
                    func 50000 |> Expect.within (Relative 1.0e-9) 11.397003949278519
            ]
        , describe "argMax"
            [ test "Encontra o máximo de uma lista pequena" <|
                \_ ->
                    let
                        data =
                            List.range 1 999 |> List.map String.fromInt
                    in
                    argMax String.length data |> Expect.equal (Just ( "100", 3 ))
            , test "Encontra o máximo para uma lista grande capaz de estourar a pilha" <|
                \_ ->
                    let
                        data =
                            List.range 1 50000

                        f =
                            String.fromInt >> String.length
                    in
                    argMax f data |> Expect.equal (Just ( 10000, 5 ))
            ]
        , describe "partition"
            [ test "Particiona uma lista corretamente" <|
                \_ ->
                    let
                        data =
                            List.range 1 10

                        isEven n =
                            modBy 2 n == 0
                    in
                    Expect.equal
                        ( [ 2, 4, 6, 8, 10 ], [ 1, 3, 5, 7, 9 ] )
                        (partition isEven data)
            ]
        ]
