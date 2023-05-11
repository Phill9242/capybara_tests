def boas_vindas()
    puts "Olá, vamos jogar um jogo..."
end

def jogar_novamente?
    puts "Gostaria de jogar outra vez ? (S / N)"
    jogar = gets.strip.upcase
    return jogar == 'S'
end

def pedir_chute()
    print "escolha uma letra ou palavra: "
    chute = gets.strip.downcase.chomp
    return chute
end

def exibir_dados_do_jogo(palavra_ate_agora, vidas, letras_chutadas)
    puts
    puts "Letras tentadas: #{letras_chutadas.sort}"
    puts "Vidas restantes: #{vidas} "
    for letra in palavra_ate_agora
        print "#{letra} "
    end
    puts "\n\n"
end

def exibir_mensagem_ja_chutou()
    puts "Você já tentou essa letra !"
end

def exibir_mensagem_acertou()
    puts "\nParabéns, você ganhou!\nA palavra secreta era #{palavra_secreta}"
end

def exibir_mensagem_perdeu()
    puts "Você perdeu!\nA palavra secreta era #{palavra_secreta}"
end