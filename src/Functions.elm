module Functions exposing (..)

{-| Este módulo define funções diversas.
-}


{-| Calcula uma soma harmônica até o número dado.

Modifique esta função para usar recursão de cauda.

-}
func : Int -> Float
func x =
    if x <= 0 then
        0

    else
        1 / toFloat x + func (x - 1)


{-| Calcula o par do maior valor de uma função e seu argumento.

Modifique esta função para usar recursão de cauda ou fold.

-}
argMax : (a -> number) -> List a -> Maybe ( a, number )
argMax f xs =
    case xs of
        [] ->
            Nothing

        head :: rest ->
            let
                value =
                    f head
            in
            case argMax f rest of
                Nothing ->
                    Just ( head, value )

                Just ( maxArg, maxValue ) ->
                    if value >= maxValue then
                        Just ( head, value )

                    else
                        Just ( maxArg, maxValue )


{-| Divide uma lista em duas listas com base em um predicado.

Os valores para os quais o predicado retorna `True` devem ir para a primeira lista, e os outros para a segunda, na ordem original.

-}
partition : (a -> Bool) -> List a -> ( List a, List a )
partition predicate list =
    ( [], [] )
