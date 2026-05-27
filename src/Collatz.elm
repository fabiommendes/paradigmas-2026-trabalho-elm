module Collatz exposing (..)

{-| Este módulo não é um exercício, mas só uma curiosidade/bug misterioso que
encontrei tentando fazer exemplos para a lista.

O código abaixo é uma implementação da função que calcula o tamanho de uma
sequência de Collatz até chegar no número 1 (<https://en.wikipedia.org/wiki/Collatz_conjecture>).

-}

import Html



-- O código abaixo calcula o tamanho de uma sequência de Collatz para um dado
-- número.
--
-- A implementação não usa a recursão de cauda e é esperada falhar em números
-- grandes causando um estouro de pilha no Javascript. Normalmente o Nodejs tem um
-- limite de 10.000 chamadas recursivas, então precisaria um número com uma semente
-- que gere uma sequência de Collatz com mais de 10.000 elementos para causar o
-- erro (provavelmente 5.000 funcionaria já que o Elm introduz uma chamada de função
-- adicional por cada passo).


collatzSize : Int -> Int
collatzSize n =
    if n == 1 then
        1

    else if (n |> modBy 2) == 0 then
        1 + collatzSize (n // 2)

    else
        1 + collatzSize (3 * n + 1)



-- A implementação com recursão de cauda (tail call), que deveria funcionar para
-- números maiores sem causar um estouro de pilha. No entanto, quando fazemos isso
-- o código entra em um loop infinito!


collatzSizeTC : Int -> Int
collatzSizeTC n =
    let
        run acc x =
            if x == 1 then
                acc

            else if (x |> modBy 2) == 0 then
                run (acc + 1) (x // 2)

            else
                run (acc + 1) (3 * x + 1)
    in
    run 1 n



-- Tentei usar exemplos da sequência de números que batem o recorde de tamanho
-- de sequência de Collatz. Isto é catalogado na Enciclopédia de Sequências de
-- Números Inteiros (OEIS) e o problema aparece a partir do número 1723519.
--
-- A006877 (https://oeis.org/A006877)
-- 2, 3, 6, 7, 9, 18, 25, 27, 54, 73, 97, 129, 171, 231, 313, 327, 649, 703, 871,
-- 1161, 2223, 2463, 2919, 3711, 6171, 10971, 13255, 17647, 23529, 26623, 34239,
-- 35655, 52527, 77031, 106239, 142587, 156159, 216367, 230631, 410011, 511935,
-- 626331, 837799, 1117065, 1501353, ==1723519==, 2298025, 3064033, 3542887, 3732423,
-- 5649499, 6649279, 8400511, 11200681, 14934241, 15733191, 31466382 ...
--
-- Fiz um código Python para verificar se acontece algo estranho a partir desse
-- limiar. Mas aparentemente não: a sequência tem 557 passos e o valor máximo
-- 46571871940 possui 36 bits, dentro da capacidade de 53 bits dos tipos
-- inteiros do Javascript.
--
-- O código Elm também começa a falhar antes de chegar nesse número. Por exemplo,
-- no valor anterior da sequência, 1501353, o Elm retorna uma resposta incorreta,
-- 648 vs 531 no Python :/
--
-- Tudo muito misterioso! Será que você consegue descobrir o que está acontecendo?
--
-- Dica: tem a ver como o Javascript representa números inteiros e realiza
-- operações bitwise nos mesmos.
--
-- Dica 2: se convertermos o código para usar floats internamente, o problema
-- desaparece por um tempo. É claro que existe um argumento grande o suficiente
-- para causar problemas de precisão, mas é possível avançar alguns números
-- adicionais na sequência...


{-| Elm só gera javascript (usando elm make) se o módulo tiver uma função `main`.
-}
main : Html.Html msg
main =
    Html.div []
        [ Html.text (String.fromInt (collatzSizeTC 1501353))
        , Html.text (String.fromInt (collatzSize 1501353))
        ]
