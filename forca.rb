def escrever_pausadamente (frase)
    for letra in frase.split('')
        print letra
        sleep (0.15)
    end
    puts
end


def boas_vindas()
    escrever_pausadamente ("Hello, darling ")
    escrever_pausadamente ("Let's play a game ...")
end

boas_vindas