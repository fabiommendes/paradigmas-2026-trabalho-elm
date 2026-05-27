module LibraryAdvancedTest exposing (tests)

import Dict
import Expect
import Library
    exposing
        ( Book
        , Library
        , borrowBookTo
        , findBookById
        , removeBookById
        , returnBook
        )
import Test exposing (..)


book1 : Book
book1 =
    { id = 1
    , title = "Programming Elm"
    , author = "Jeremy Fairbank"
    , year = 2019
    , copies = 3
    , borrowedBy = []
    }


book2 : Book
book2 =
    { id = 2
    , title = "Domain Modeling Made Functional"
    , author = "Scott Wlaschin"
    , year = 2018
    , copies = 2
    , borrowedBy = [ "Ana" ]
    }


book3 : Book
book3 =
    { id = 3
    , title = "Clean Code"
    , author = "Robert Martin"
    , year = 2008
    , copies = 1
    , borrowedBy = [ "Carlos" ]
    }


sampleLibrary : Library
sampleLibrary =
    Dict.fromList
        [ ( book1.id, book1 )
        , ( book2.id, book2 )
        , ( book3.id, book3 )
        ]


tests : Test
tests =
    describe "Operações complexas da biblioteca"
        [ describe "removeBookById"
            [ test "Remove uma quantidade válida de exemplares" <|
                \_ ->
                    case removeBookById 1 1 sampleLibrary of
                        Ok updatedLibrary ->
                            case findBookById 1 updatedLibrary of
                                Just updatedBook ->
                                    updatedBook.copies |> Expect.equal 2

                                Nothing ->
                                    Expect.fail "Livro deveria existir"

                        Err _ ->
                            Expect.fail "Esperava remoção válida"
            , test "Retorna erro ao remover livro inexistente" <|
                \_ ->
                    case removeBookById 999 1 sampleLibrary of
                        Ok _ ->
                            Expect.fail "Esperava erro ao remover livro inexistente"

                        Err msg ->
                            msg |> Expect.equal "NOT_FOUND"
            , test "Retorna erro ao remover mais cópias do que disponível" <|
                \_ ->
                    case removeBookById 1 4 sampleLibrary of
                        Ok _ ->
                            Expect.fail "Esperava erro ao remover mais cópias do que disponível"

                        Err msg ->
                            msg |> Expect.equal "NOT_ENOUGH_COPIES"
            ]
        , describe "borrowBookTo"
            [ test "Empresta livro com cópias disponíveis" <|
                \_ ->
                    case borrowBookTo "Maria" 1 sampleLibrary of
                        Ok updatedLibrary ->
                            case findBookById 1 updatedLibrary of
                                Just updatedBook ->
                                    List.member "Maria" updatedBook.borrowedBy |> Expect.equal True

                                Nothing ->
                                    Expect.fail "Livro deveria existir"

                        Err _ ->
                            Expect.fail "Esperava empréstimo válido"
            , test "Retorna erro para livro inexistente" <|
                \_ ->
                    case borrowBookTo "Maria" 999 sampleLibrary of
                        Ok _ ->
                            Expect.fail "Esperava erro"

                        Err msg ->
                            msg |> Expect.equal "NOT_FOUND"
            , test "Retorna erro quando não há cópias disponíveis" <|
                \_ ->
                    case borrowBookTo "Ana" 3 sampleLibrary of
                        Ok _ ->
                            Expect.fail "Esperava erro"

                        Err msg ->
                            msg |> Expect.equal "NOT_ENOUGH_COPIES"
            ]
        , describe "returnBook"
            [ test "Remove usuário da lista de empréstimos" <|
                \_ ->
                    case returnBook "Ana" 2 sampleLibrary of
                        Ok updatedLibrary ->
                            case findBookById 2 updatedLibrary of
                                Just updatedBook ->
                                    List.member "Ana" updatedBook.borrowedBy |> Expect.equal False

                                Nothing ->
                                    Expect.fail "Livro deveria existir"

                        Err _ ->
                            Expect.fail "Esperava devolução válida"
            , test "Retorna erro ao devolver livro inexistente" <|
                \_ ->
                    case returnBook "Ana" 999 sampleLibrary of
                        Ok _ ->
                            Expect.fail "Esperava erro"

                        Err msg ->
                            msg |> Expect.equal "NOT_FOUND"
            , test "Retorna erro quando usuário não possui empréstimo" <|
                \_ ->
                    case returnBook "Maria" 2 sampleLibrary of
                        Ok _ ->
                            Expect.fail "Esperava erro"

                        Err msg ->
                            msg |> Expect.equal "USER_DID_NOT_BORROW"
            ]
        ]
