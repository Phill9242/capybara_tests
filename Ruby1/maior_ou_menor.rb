def dar_boas_vindas()
    puts    "Qual seu nome ?"
    nome = gets.chomp
    puts    "\nBem-vindo, #{nome}. \nVamos jogar um jogo !"
    puts    "\nIrei escolher um número entre 0 e 200"
end

def sortear_numero_secreto()
    for i in 0 .. 2
        print "."
        sleep (1)
    end
    numero_sorteado = rand(201)
    puts "\nPronto! Escolha seu número e vamos começar:\n\n"
    return (numero_sorteado)
end

def checar_numero(numero)
    begin
      numero_int = Integer(numero)
      if numero_int < 0 || numero_int > 200
        puts "Escolha um número entre 0 e 200\n\n"
        return false
      end
    rescue ArgumentError
      puts "Apenas números são aceitos!\n\n"
      return false
    end
    return true
end

def pegar_numero_usuario
    begin
      numero_usuario = gets.chomp
    end while checar_numero(numero_usuario) == false
    numero_usuario
  end
    
def adivinhar_numero (numero_secreto)
    limite_tentativa = 5
    tentativa = 1
    while tentativa <= limite_tentativa
        puts "Tentativa #{tentativa} de #{limite_tentativa} "
        numero_usuario = pegar_numero_usuario()
        if numero_usuario.to_i < numero_secreto
            puts "\nSeu número está abaixo !"
        elsif numero_usuario.to_i > numero_secreto  
            puts "\nSeu número está acima !"   
        else
            puts "Parabéns, o número que eu escolhi era #{numero_secreto}! \n" 
            return
        end
        tentativa += 1
    end
    puts "\nVocê perdeu :(\nO Número escolhido era #{numero_secreto} "
end

def maior_ou_menor()
    dar_boas_vindas()
    numero_secreto = sortear_numero_secreto()
    adivinhar_numero(numero_secreto)

end

maior_ou_menor()