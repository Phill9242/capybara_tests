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
    chute = gets.strip.downcase.chomp
    return chute
end

def preencher_palavra_ate_agora(palavra_ate_agora, palavra_secreta, chute_atual)
    i = 0
    while i < palavra_secreta.size
        if palavra_secreta[i] == chute_atual
            palavra_ate_agora[i] = chute_atual
        end
        i += 1
    end
end

def checar_letra(chute_atual, palavra_secreta, palavra_ate_agora)
    if palavra_secreta.include?(chute_atual)
        preencher_palavra_ate_agora(palavra_ate_agora, palavra_secreta, chute_atual)
        return true
    end
    return false
end

def exibir_estado_atual(palavra_ate_agora, vidas, letras_chutadas)
    puts
    puts "Letras tentadas: #{letras_chutadas.sort}"
    puts "Vidas restantes: #{vidas} "
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
        errou_letra = true
        exibir_estado_atual(palavra_ate_agora, vidas, letras_chutadas)
        chute_atual = pedir_chute()
        chutou_uma_letra = chute_atual.size == 1
        if letras_chutadas.include?(chute_atual)
            puts "Você já tentou essa letra !"
            next
        end
        if chutou_uma_letra
            letras_chutadas << chute_atual
            if checar_letra(chute_atual, palavra_secreta, palavra_ate_agora)
                errou_letra = false
            end
        end
        if chute_atual == palavra_secreta || !palavra_ate_agora.include?("_")
            puts "\nParabéns, você ganhou!\nA palavra secreta era #{palavra_secreta}"
            return
        end

        if errou_letra
            vidas -=1
        end

        break if vidas == 0
    end
    puts "Você perdeu!\nA palavra secreta era #{palavra_secreta}"
end

def main()
    boas_vindas
    loop do
        palavra_secreta = escolher_palavra_secreta
        jogar(palavra_secreta)
        break unless jogar_novamente?
    end
end

main()