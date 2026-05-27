module MyList exposing (..)

{-| Este módulo define uma estrutura de lista simplesmente encadeada personalizada e funções para manipulá-la.
-}


type MyList a
    = Nil
    | Cons a (MyList a)


{-| Converte uma lista padrão do Elm para uma lista personalizada `MyList`.
-}
fromList : List a -> MyList a
fromList xs =
    Nil


{-| Converte uma lista personalizada `MyList` para uma lista padrão do Elm.
-}
toList : MyList a -> List a
toList myList =
    []


{-| Exibe como string
-}
toString : (a -> String) -> MyList a -> String
toString show myList =
    "[]"


{-| Aplica uma função a cada elemento da lista, retornando uma nova lista com os resultados.
-}
map : (a -> b) -> MyList a -> MyList b
map f list =
    Nil


{-| Filtra os elementos da lista que satisfazem um predicado, retornando uma nova lista com os elementos que passam no teste.
-}
filter : (a -> Bool) -> MyList a -> MyList a
filter predicate list =
    Nil


{-| Reduz uma lista a um único valor usando uma função de acumulação e um valor inicial.

o foldl processa a lista da esquerda para a direita, enquanto o foldr processa da direita para a esquerda.

    foldl (++) "!" (fromList [ "a", "b", "c" ]) == "!abc"

IMPORTANTE: Usamos a convenção do Haskell para os argumentos de foldl.
Note que em Elm, f :: (a -> b -> b), ou seja, o acumulador é o segundo
argumento da função, e o elemento da lista é o primeiro.

-}
foldl : (b -> a -> b) -> b -> MyList a -> b
foldl f acc list =
    acc


{-| Reduz uma lista a um único valor usando uma função de acumulação e um valor inicial.

o foldr processa a lista da direita para a esquerda, enquanto o foldl processa da esquerda para a direita.

    foldr (++) "!" (fromList [ "a", "b", "c" ]) == "!abc"

-}
foldr : (a -> b -> b) -> b -> MyList a -> b
foldr f acc list =
    acc
