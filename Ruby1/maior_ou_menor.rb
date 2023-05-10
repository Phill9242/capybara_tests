def dar_boas_vindas()
    puts    "Qual seu nome ?"
    nome = gets.chomp
    puts    "\nBem-vindo, #{nome}. \nVamos jogar um jogo !"
end

def sortear_numero_secreto(dificuldade)
    puts    "\nIrei escolher um número entre 1 e #{dificuldade}"
    for i in 0 .. 2
        print "."
        sleep (1)
    end
    numero_sorteado = rand(1 .. dificuldade)
    puts "\nPronto! Escolha seu número e vamos começar:\n\n"
    return (numero_sorteado)
end

def checar_numero(numero, dificuldade)
    begin
      numero_int = Integer(numero)
      if numero_int < 1 || numero_int > dificuldade
        puts "Escolha um número entre 1 e #{dificuldade}! \n\n"
        return false
      end
    rescue ArgumentError
      puts "Apenas números são aceitos!\n\n"
      return false
    end
    return true
end

def pegar_numero_usuario_valido(dificuldade)
    begin
        print "Seu palpite atual: "
        numero_usuario = gets.chomp
    end while checar_numero(numero_usuario, dificuldade) == false
    return numero_usuario
  end

def acertou_numero_secreto(numero_usuario, numero_secreto)
    if numero_usuario < numero_secreto
        puts "Seu número está abaixo !\n\n"
        return false
    end
    if numero_usuario > numero_secreto  
        puts "Seu número está acima !\n\n"
        return false
    end
    puts "Parabéns, o número que eu escolhi era #{numero_secreto}! \n\n" 
    return true
end

def adivinhar_numero (numero_secreto, dificuldade)
    tentativas_anteriores = []
    limite_tentativa = 5
    tentativa = 1

    while tentativa <= limite_tentativa
        puts "Tentativa #{tentativa} de #{limite_tentativa} "
        puts "Você já tentou os números: #{tentativas_anteriores}"
        numero_usuario = pegar_numero_usuario_valido(dificuldade)
        if acertou_numero_secreto(numero_usuario.to_i, numero_secreto)
            return
        end
        tentativas_anteriores.push(numero_usuario)
        tentativa += 1
    end

    puts "\nVocê perdeu :(\nO Número escolhido era #{numero_secreto} "
end

def escolher_dificuldade()
    dificuldade = nil
    intervalo_entre_cada_dificuldade = 30

    loop do
        puts "Escolha uma dificuldade entre 1 (mais fácil) e 5 (mais difícil)"
        dificuldade = gets.chomp.to_i
        break if dificuldade >= 1 && dificuldade <= 5
    end

    return dificuldade * intervalo_entre_cada_dificuldade    
end

def nao_quer_jogar_novamente()
    puts "Quer jogar outra vez ? (S / N)"
    resposta = gets.strip
    return resposta.upcase != 'S'
end

def maior_ou_menor()
    dar_boas_vindas()
    loop do  
        dificuldade = escolher_dificuldade()
        numero_secreto = sortear_numero_secreto(dificuldade)
        adivinhar_numero(numero_secreto, dificuldade)
        break if nao_quer_jogar_novamente()
    end
end

maior_ou_menor()