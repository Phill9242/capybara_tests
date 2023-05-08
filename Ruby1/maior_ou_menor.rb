# função integer para levantar uma exception
# caso o input do usuário não seja um número, uma exceção é levantada com uma mensagem
# caso seja um inteiro, faz uma verificação se o número está dentro do range
def numero_invalido(numero)
    begin
      numero_int = Integer(numero)
      if numero_int < 0 || numero_int > 200
        return true
      end
    rescue ArgumentError
      puts "Apenas números são aceitos!"
      return true
    end
    return false
  end

# puts coloca automaticamente uma quebra de linha ao final
puts    "Qual seu nome ?"

#o método chomp remove a quebra de linha final de uma string
nome = gets.chomp

puts    "\nBem-vindo, #{nome}. \nVamos jogar um jogo !"
puts    "\nIrei escolher um número entre 0 e 200"

#a função rand escolhe um número aleatório. 
# Caso apenas um parâmetro seja passado, o range inicial é 0, sendo seguido de números inteiros conseguintes até o limite passado
numero_secreto = rand(201)

#um loop para emular a "escolha" do computador
#a melhor saída nesse caso é utilizar print, pois não adiciona a quebra de linha ao final entre cada ponto
for i in 0 .. 2
    print "."
    sleep (1)
end

puts "\nPronto! Escolha seu número e vamos começar:\n\n"

# Laço que fica em loop até que o número escolhido pelo usuário esteja correto
# devolve mensagens personalizadas dependendo do palpite do usuário ser correto ou não
acerto = false
limite_tentativa = 5
for tentativa in 1..limite_tentativa
    puts "Tentativa #{tentativa} de #{limite_tentativa} "
    numero_usuario = gets.chomp
    if numero_invalido (numero_usuario)
        puts "Por favor, escolha um número entre 0 e 200 !\n"
    elsif numero_usuario.to_i < numero_secreto
        puts "\nSeu número está abaixo !"
    elsif numero_usuario.to_i > numero_secreto  
        puts "\nSeu número está acima !"   
    else
        puts "Parabéns, o número que eu escolhi era #{numero_secreto}! \n" 
        acerto = true  
        break
    end
    
end

if acerto == false
    puts "\nVocê perdeu :(\nO Número escolhido era #{numero_secreto} "
end

