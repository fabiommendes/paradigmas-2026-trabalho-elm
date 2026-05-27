
def collatz(n: int):
    yield n
    while n != 1:
        yield (n := n // 2 if n % 2 == 0 else 3 * n + 1)

if __name__ == "__main__":
    n = int(input("n: "))
    print("tamanho       : ", sum(1 for _ in collatz(n)))
    print("máximo        : ", n_max := max(collatz(n)))
    print("número de bits: ", n_max.bit_length())
    if input("mostrar sequência? (s/n) ").lower() == "s":
        for i, x in enumerate(collatz(n)):
            print(f"{i:4}: {x}")
