def escrever_pausadamente(frase)
    for letra in frase.split('')
        print letra
        # sleep (0.15)
    end
    puts
end

def escolher_palavra_secreta
    palavra_secreta = "pirulito"
    return palavra_secreta
end

def jogar_novamente?
    escrever_pausadamente("Gostaria de jogar outra vez ? (S / N)")
    jogar = gets.strip.upcase
    return jogar == 'S'
end

def boas_vindas()
    escrever_pausadamente("Hello, darling ")
    escrever_pausadamente("Let's play a game ...")
    escrever_pausadamente("I'll gonna choose a word and you will have few attempts to guess what I thinking ...")
end

def pedir_chute()
    print "escolha uma letra ou palavra: "
    chute = gets.strip.downcase
    return chute
end

def checar_letra(chute_atual, palavra_secreta)
    return palavra_secreta.include?(chute_atual)
end

def exibir_palavra(palavra_ate_agora)
    puts
    for letra in palavra_ate_agora
        print "#{letra} "
    end
    puts "\n\n"
end

def preencher_array_com_linhas(letras)
    array_vazio = []
    for letra in 1 .. letras
        array_vazio << '_'
    end
    return array_vazio
end

def jogar(palavra_secreta)
    vidas = 5
    letras_chutadas = []
    palavra_ate_agora = preencher_array_com_linhas(palavra_secreta.size)
    loop do
        exibir_palavra (palavra_ate_agora)
        chute_atual = pedir_chute()
        chutou_uma_letra = chute_atual.size == 1

        if letras_chutadas.include?(chute_atual)
            puts "Você já tentou essa letra !"
            next
        end
        if chutou_uma_letra
            letras_chutadas << chute_atual
            palavra_ate_agora = checar_letra(chute_atual, palavra_secreta)
        end 

        break 
       
    end

end



boas_vindas
loop do
    palavra_secreta = escolher_palavra_secreta
    jogar(palavra_secreta)
    break unless jogar_novamente?
end