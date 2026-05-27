module LibraryBasicTest exposing (tests)

import Dict
import Expect
import Library
    exposing
        ( Book
        , Library
        , addBook
        , availableBooks
        , borrowedBooks
        , countBooks
        , findBookById
        , findBooksByAuthor
        , findBorrowedBooksByUser
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
    describe "Library"
        [ describe "countBooks"
            [ test "Conta corretamente a quantidade de livros cadastrados" <|
                \_ ->
                    Expect.equal
                        6
                        (countBooks sampleLibrary)
            ]
        , describe "addBook"
            [ test "Adiciona um novo livro à biblioteca" <|
                \_ ->
                    let
                        newBook =
                            { id = 4
                            , title = "Elm in Action"
                            , author = "Richard Feldman"
                            , year = 2020
                            , copies = 5
                            , borrowedBy = []
                            }

                        updatedLibrary =
                            addBook newBook sampleLibrary
                    in
                    Expect.equal
                        11
                        (countBooks updatedLibrary)
            , test "Atualiza número de cópias quando o livro já existe" <|
                \_ ->
                    let
                        duplicateBook =
                            { book1 | copies = 2 }

                        updatedLibrary =
                            addBook duplicateBook sampleLibrary
                    in
                    Expect.equal
                        8
                        (countBooks updatedLibrary)
            ]
        , describe "findBooksByAuthor"
            [ test "Filtra livros pelo autor" <|
                \_ ->
                    let
                        books =
                            findBooksByAuthor
                                "Robert Martin"
                                sampleLibrary
                    in
                    Expect.equal
                        1
                        (List.length books)
            ]
        , describe "findBookById"
            [ test "Retorna Just quando o livro existe" <|
                \_ ->
                    case findBookById 1 sampleLibrary of
                        Just book ->
                            Expect.equal
                                "Programming Elm"
                                book.title

                        Nothing ->
                            Expect.fail "Esperava encontrar o livro"
            , test "Retorna Nothing quando o livro não existe" <|
                \_ ->
                    Expect.equal
                        Nothing
                        (findBookById 999 sampleLibrary)
            ]
        , describe "availableBooks"
            [ test "Retorna livros com cópias disponíveis" <|
                \_ ->
                    let
                        books =
                            availableBooks sampleLibrary
                    in
                    Expect.equal
                        2
                        (List.length books)
            ]
        , describe "borrowedBooks"
            [ test "Retorna livros atualmente emprestados" <|
                \_ ->
                    let
                        books =
                            borrowedBooks sampleLibrary
                    in
                    Expect.equal
                        2
                        (List.length books)
            ]
        , describe "findBorrowedBooksByUser"
            [ test "Retorna livros emprestados por um usuário específico" <|
                \_ ->
                    let
                        books =
                            findBorrowedBooksByUser "Ana" sampleLibrary
                    in
                    Expect.equal
                        "Domain Modeling Made Functional"
                        (List.head books |> Maybe.map .title |> Maybe.withDefault "")
            ]
        ]
