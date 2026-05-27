module MyListTest exposing (tests)

import Expect
import MyList exposing (..)
import Test exposing (..)


abc : MyList String
abc =
    Cons "a" (Cons "b" (Cons "c" Nil))


my123 : MyList Int
my123 =
    Cons 1 (Cons 2 (Cons 3 Nil))


tests : Test
tests =
    describe "MyList"
        [ describe "fromList"
            [ test "Converte uma lista padrão para MyList" <|
                \_ ->
                    fromList [ 1, 2, 3 ] |> Expect.equal my123
            ]
        , describe "toList"
            [ test "Converte uma MyList para lista padrão" <|
                \_ ->
                    toList abc |> Expect.equal [ "a", "b", "c" ]
            ]
        , describe "toString"
            [ test "Exibe MyList como string" <|
                \_ ->
                    toString identity abc |> Expect.equal "[ a, b, c ]"
            , test "Exibe MyList vazia como string" <|
                \_ ->
                    toString identity Nil |> Expect.equal "[]"
            ]
        , describe "map"
            [ test "Aplica função a cada elemento da lista" <|
                \_ ->
                    map ((+) 1) my123
                        |> toString String.fromInt
                        |> Expect.equal "[ 2, 3, 4 ]"
            ]
        , describe "filter"
            [ test "Filtra elementos que satisfazem o predicado" <|
                \_ ->
                    filter (\x -> (x |> modBy 2) == 1) my123
                        |> toString String.fromInt
                        |> Expect.equal "[ 1, 3 ]"
            ]
        , describe "foldl"
            [ test "Reduz a lista usando foldl" <|
                \_ ->
                    foldl (++) "!" abc |> Expect.equal "!abc"
            ]
        , describe "foldr"
            [ test "Reduz a lista usando foldr" <|
                \_ ->
                    foldr (++) "!" abc |> Expect.equal "abc!"
            ]
        ]
