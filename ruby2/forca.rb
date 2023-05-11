require_relative ("ui")

def escolher_palavra_secreta
    palavra_secreta = "pirulito"
    return palavra_secreta
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

def existe_letra_dentro_da_palavra(chute_atual, palavra_secreta, palavra_ate_agora)
    if palavra_secreta.include?(chute_atual)
        preencher_palavra_ate_agora(palavra_ate_agora, palavra_secreta, chute_atual)
        return true
    end
    return false
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
        exibir_dados_do_jogo(palavra_ate_agora, vidas, letras_chutadas)
        chute_atual = pedir_chute()
        chutou_uma_letra = chute_atual.size == 1

        if letras_chutadas.include?(chute_atual)
            exibir_mensagem_ja_chutou()
            next
        end
        
        if chutou_uma_letra
            letras_chutadas << chute_atual
            if existe_letra_dentro_da_palavra(chute_atual, palavra_secreta, palavra_ate_agora)
                errou_letra = false
            end
        end

        if chute_atual == palavra_secreta || !palavra_ate_agora.include?("_")
            exibir_mensagem_acertou()
            return
        end

        if errou_letra
            vidas -=1
        end

        break if vidas == 0
    end
    exibir_mensagem_perdeu()
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