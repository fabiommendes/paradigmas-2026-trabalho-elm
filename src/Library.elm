module Library exposing
    ( Book
    , Library
    , addBook
    , availableBooks
    , borrowBookTo
    , borrowedBooks
    , countBooks
    , findBookById
    , findBooksByAuthor
    , findBorrowedBooksByUser
    , removeBookById
    , returnBook
    )

-- Referência: https://package.elm-lang.org/packages/elm/core/latest/Dict

import Dict exposing (Dict)


type alias User =
    String


type alias BookId =
    Int


type alias Book =
    { id : BookId
    , title : String
    , author : String
    , year : Int
    , copies : Int
    , borrowedBy : List User
    }


type alias Library =
    Dict BookId Book


addBook : Book -> Library -> Library
addBook book library =
    -- TODO: Implementar
    library


removeBookById : BookId -> Int -> Library -> Result String Library
removeBookById bookId quantity library =
    -- TODO: Implementar
    Ok library


findBookById : BookId -> Library -> Maybe Book
findBookById bookId library =
    -- TODO: Implementar
    Nothing


findBooksByAuthor : String -> Library -> List Book
findBooksByAuthor author library =
    -- TODO: Implementar
    []


findBorrowedBooksByUser : User -> Library -> List Book
findBorrowedBooksByUser user library =
    -- TODO: Implementar
    []


countBooks : Library -> Int
countBooks library =
    -- TODO: Implementar
    0


availableBooks : Library -> List ( Book, Int )
availableBooks library =
    -- TODO: Implementar
    []


borrowedBooks : Library -> List ( Book, Int )
borrowedBooks library =
    -- TODO: Implementar
    []


borrowBookTo : User -> Int -> Library -> Result String Library
borrowBookTo user bookId library =
    -- TODO: Implementar
    Ok library


returnBook : User -> Int -> Library -> Result String Library
returnBook user bookId library =
    -- TODO: Implementar
    Ok library
