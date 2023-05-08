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
puts    "Qual seu nome ?\n"

#o método chomp remove a quebra de linha final de uma string
nome = gets.chomp

puts    "Bem-vindo, #{nome}. \n\nVamos jogar um jogo !"
puts    "Irei escolher um número entre 0 e 200"

#a função rand escolhe um número aleatório. 
# Caso apenas um parâmetro seja passado, o range inicial é 0, sendo seguido de números inteiros conseguintes até o limite passado
numero_aleatorio = rand(201)

#um loop para emular a "escolha" do computador
#a melhor saída nesse caso é utilizar print, pois não adiciona a quebra de linha ao final entre cada ponto
for i in 0 .. 2
    print "."
    sleep (1)
end

puts "\nPronto.\nEscolha seu número e vamos começar:"

while (1)
    numero_usuario = gets.chomp
    if numero_invalido (numero_usuario)
        puts "Por favor, escolha um número entre 0 e 200 !"
    elsif numero_usuario.to_i < numero_aleatorio
        puts "Seu número está abaixo !\n"
    elsif numero_usuario.to_i > numero_aleatorio
        puts "Seu número está acima !\n"   
    else
        puts "Parabéns, o número que eu escolhi era #{numero_aleatorio}! \n"   
        break
    end
end
    

