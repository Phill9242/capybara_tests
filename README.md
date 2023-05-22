# Guia de desenvolvimento de testes com Capybara 

Este guia tem como objetivo auxiliar os colaboradores da Orça Fascio a criar testes de qualidade utilizando a GEM Capybara.

___
## Índice

-[Orientações Gerais](#orientações-gerais)

-[Capybara e sua DSL](#capybara-e-sua-dsl)
  -[Capybara GEM](#capybara-gem)
  -[Configurando sua aplicação](#configurando-sua-aplicação)
    -[Gemfile](#gemfile)
-[Testando uma aplicação](#testando-uma-aplicação)

___
## Orientações Gerais

### Capybara GEM

Capybara é uma ferramenta para auxliar a criação de testes automatizados em Ruby. Com capybara é possível simular a interação do usuário com o seu site e verificar se a forma como sua aplicação responde as interações do usuário está dentro do esperado.

*Utilizaremos a versão 3.26 do Capybara, que é compatível com as versões Ruby 2.7.7 e 3.1.0, utilizadas nos projetos da Orça Fascio.*
<br><br>
 
### Configurando sua aplicação

#### Gemfile

É necessário que sua *Gemfile* contenha as seguintes GEM's:

``` gem 'capybara', '>= 3.26```

A gem 'capybara' é a biblioteca principal que vamos usar para escrever e gerenciar os nossos testes. Ela permite que simulemos a interação do usuário com o nosso aplicativo web e verifiquemos se a aplicação está respondendo como esperado.

```gem 'selenium-webdriver', '~> 4.4'```

A gem 'selenium-webdriver' é uma biblioteca que fornece a interface entre o Capybara e o navegador web. É através do Selenium que o Capybara "conversa" com o navegador, emitindo comandos para navegar para diferentes páginas, clicar em links, preencher formulários, etc. Por padrão, o Capybara usa o driver Selenium.

``` gem 'webdrivers', '~> 5.2'``` 

A gem 'webdrivers' é uma ferramenta auxiliar que lida com a instalação e atualização dos drivers do navegador que são usados pelo Selenium. Isso torna muito mais fácil trabalhar com diferentes navegadores e diferentes versões de navegadores, pois a gem 'webdrivers' cuida da parte complicada de garantir que nós teremos o driver certo para os navegadores que iremos utilizar.<br><br>

#### Configuração capybara 

Vamos criar um arquivo para nossa configuração Capybara:

Em primeiro lugar, crie uma pasta dentro do diretório ```test``` com o nome ```support```, dento da pasta, crie um arquivo com o nome ```capybara.config.rb```.
*Note que o nome da pasta ou do arquivo de configuração podem ser diferentes, mas seguiremos uma padronização para facilitar o desenvolvimento*

Para fazer as configurações do seu teste, adicone ao seu arquivo criado:

```
require 'capybara/rails'

Capybara.configure do |config|
  # configurações
end
```
*Para verificar todas as configurações disponíveis consulte a [documentação](https://www.rubydoc.info/gems/capybara/Capybara.configure).*

Para termos certeza que o nosso arquivo de configuração vai ser lido, adicionaremos a seguinte linha ao arquivo *./test/test_helper.rb*: ```require 'support/capybara.config'```<br><br>
___

## Capybara e sua DSL

### O que é DSL (Domain Specific Language) ?
Em linhas gerais, DSL é uma linguagem de programação (ou de script) com o objetivo de resolver um problema dentro de um escopo específico, por isso o nome *Linguagem Específica de Domínio*. No nosso caso, o objetivo da DSL é nos ajudar a interagir com os elementos presentes dentro de uma página web, pois é através dessas páginas que a maior parte dos nossos usuários interage com nossas aplicações.

### Métodos de Navegação

Métodos disponíveis para acessar páginas da aplicação ou mesmo páginas externas.

#### visit
Responsável por navegar até uma página específica - ```visit(visit_uri)```

* visit é um método que recebe apenas um parâmetro (o endereço que você desejar navegar); 
* O seu método de request será sempre **GET**;
* Para navegar até alguma página, podemos utilizar o url absoluto, as rotas definidas no projeto Rails ou mesmo utilizar as rotas em conjunto, como nos exemplos abaixo;

Exemplo de testes:

*URL absoluto*
```
# Navega até a home da OrçaFascio
test "visitar uma página" do
    visit "orcafascio.com"
end
``` 
*Rails PATH*
```
# Navega até a página de criação de novo produto
test "visitar uma página" do
    visit new_produto_path
end
```
*Rails PATH utlizando um objeto*
```
# Navega até a página de detalhes de um produto específico
test "visitar uma página " do
    visit produto_path(produto)
end
```

### Métodos de Interação com Links e Botões

Os métodos apresentados nesta seção tem como objetivo interagir com botões e links, abrangendo não apenas botões que geram uma ação, mas também aqueles que podem ser selecionados para marcar alguma opção dentro do formulário.

#### click_link  

Clica em um link disponível na página atual -  ```click_link([locator], **options)```

* click_link é um método que aceita 2 parâmetros: o primeiro é o link a ser clicado, o segundo é um parâmetro opcional, contendo as configurações adicionais;
* o primeiro parâmetro de click_link pode ser o id do link, o texto deste link ou mesmo seu título. Além disso, o capybara também pode procurar por textos dentro da imagem do link;

Exemplos de testes:

*Utilizar o texto do elemento*
```
# Clica no botão com texto 'Enviar'
test "clicar no botão Enviar" do
  visit formulario_path
  click_button 'Enviar'
  assert page.has_content?('Formulário enviado com sucesso')
end

```
*Utilizar o id do elemento*
```
# Clica no link com id 'link_sobre'
test "clicar no link sobre" do
  visit homepage_path
  click_link 'link_sobre'
  assert page.has_current_path?(sobre_path)
end
```
*Utilizar o título do elemento*
```
# Clica no link com título 'Nossa História'
test "clicar no link nossa história" do
  visit homepage_path
  click_link 'Nossa História', title: 'Nossa História'
  assert page.has_current_path?(historia_path)
end
```
*Utilizar o texto da imagem do elemento*
```
# Clica no link com imagem contendo texto 'Logo'
test "clicar no link do logo" do
  visit homepage_path
  click_link 'Logo'
  assert page.has_current_path?(homepage_path)
end
```


[Documentação click_link](https://rubydoc.info/github/teamcapybara/capybara/master/Capybara/Node/Actions#click_link-instance_method)

#### click_button 

Clica em um botão disponível na página atual - ```click_button([locator], **options)```

* click_button é um método que aceita 2 parâmetros: o primeiro é o botão a ser clicado, o segundo é um parâmetro opcional, contendo as configurações adicionais;
* o botão pode ser um elemento <input> do tipo *image*, *submit*, *reset* ou *button* ou um elemento <button>;
* o elemento <button> pode ser encontrado através do seu id, name, test_id, value, title ou texto dentro do botão;
* o elemento <input> pode ser encontrado através do seu id, name, test_id, value, title, além do tipo *image* também poder ser encontrado pelo texto *alt* da imagem;

Exemplos de testes:

*Utilizar o texto do botão*
```
# Clica no botão com texto 'Enviar'
test "clicar no botão Enviar" do
  visit formulario_path
  click_button 'Enviar'
  assert page.has_content?('Formulário enviado com sucesso')
end
```

*Utilizar o id do botão*

```
# Clica no botão com id 'botao_enviar'
test "clicar no botão Enviar por id" do
  visit formulario_path
  click_button 'botao_enviar'
  assert page.has_content?('Formulário enviado com sucesso')
end
```

*Utilizar o name do botão*

```
# Clica no botão com name 'enviar_formulario'
test "clicar no botão Enviar por name" do
  visit formulario_path
  click_button 'enviar_formulario'
  assert page.has_content?('Formulário enviado com sucesso')
end
```

*Utilizar o alt da imagem do botão*

```
# Clica no botão com imagem contendo texto 'Enviar'
test "clicar no botão Enviar por texto da imagem" do
  visit formulario_path
  click_button 'Enviar'
  assert page.has_content?('Formulário enviado com sucesso')
end
```

[Documentação click_button](https://rubydoc.info/github/teamcapybara/capybara/master/Capybara/Node/Actions#click_button-instance_method)

#### click_link_or_button 

Clica em um link ou botão na página - ```click_link_or_button([locator], **options)```
  
 * Seu modo de uso se assemelha à uma mesclagem dos métodos [click_button](#click_button) e [click_link](#click_link);
 * o cabybara será capaz de identificar se trata-se de um link ou botão de acordo com os parâmetros passados e realizará a ação de click.
 
[Documentação click_link_or_button](https://rubydoc.info/github/teamcapybara/capybara/master/Capybara/Node/Actions#click_link_or_button-instance_method)
 
 #### click_on 
 
 Clica em um link ou botão na página - ```click_on([locator], **options)```
 
 * Trata-se de um *alias* para outro método igual, para mais informações verifique [click_link_or_button](#click_link_or_button).
 
 ### Métodos de interação com formulários
 
 #### fill_in
 
 Preenche um campo de um formulário - ```fill_in([locator], with: , **options```
 
 * O método fill_in recebe 3 argumentos: o primeiro é o elemento a ser acessado, o segundo é o valor a ser preenchido dentro deste elemento e o terceiro são as opções e não é obrigatório;
 * o primeiro argumento é um *text field* ou um *text area* e pode ser encontrado através de seu id, placeholder, name, test_id ou text_label;
 * é possível, mas não aconselhado, utilizar fill_in sem um argumento de seu *locator*, pois ele irá preencher o elemento atual em que está;
 * o segundo elemento deve ser acompanhado da palavra chave *with:* seguido do texto que será inserido dentro daquele campo. Ele será interpretado como uma string, mas isso não impede de preencher campos que exijam apenas argumentos numéricos.
 
Exemplos de testes:
 
 *Utilizando o id do campo*
 ```
# Preenche o campo com id 'email' com 'test@orcafascio.com'
test "preencher o campo de email" do
  visit formulario_path
  fill_in 'email', with: 'test@orcafascio.com'
  click_button 'Enviar'
  assert page.has_content?('Formulário enviado com sucesso')
end
```

*Utilizando o nome do campo*

 ```
# Preenche o campo com name 'senha' com 'senha123'
test "preencher o campo de senha" do
  visit formulario_path
  fill_in 'senha', with: 'senha123'
  click_button 'Enviar'
  assert page.has_content?('Formulário enviado com sucesso')
end
``` 

*Utilizando o placeholder do campo*

 ``` 
# Preenche o campo com placeholder 'Digite seu nome' com 'João'
test "preencher o campo de nome" do
  visit formulario_path
  fill_in 'Digite seu nome', with: 'João'
  click_button 'Enviar'
  assert page.has_content?('Formulário enviado com sucesso')
end
``` 

*Utilizando o label do campo*

 ```
# Preenche o campo com label 'Email' com 'test@orcafascio.com'
test "preencher o campo de email pelo label" do
  visit formulario_path
  fill_in 'Email', with: 'test@orcafascio.com'
  click_button 'Enviar'
  assert page.has_content?('Formulário enviado com sucesso')
end
```

[Documentação fill_in](https://rubydoc.info/github/teamcapybara/capybara/master/Capybara/Node/Actions#fill_in-instance_method)

#### choose

Encontra um botão de seleção do tipo *radio button* e o marca como selecionado - ```choose([locator], **options)```

* O elemento pode ser encontrado através de seu name, id, test_id attribute ou label text;
* se nenhum elemento for encontrado, ele irá marcar a si mesmo ou a um elemento filho;
* o elemento deve ser um botão de rádio, onde apenas uma seleção entra várias é possível.

 Exemplos de testes:

*Utilizando o id do botão de rádio*

 ```
 # Seleciona o botão de rádio com id 'radio_sim'
test "selecionar o botão de rádio 'sim'" do
  visit formulario_path
  choose 'radio_sim'
  click_button 'Enviar'
  assert page.has_content?('Formulário enviado com sucesso')
end
 ```
 
*Utilizando o nome do botão de rádio*

 ```
 # Seleciona o botão de rádio com name 'resposta'
test "selecionar o botão de rádio 'resposta'" do
  visit formulario_path
  choose 'resposta'
  click_button 'Enviar'
  assert page.has_content?('Formulário enviado com sucesso')
end
```

*Utilizando o label do botão de rádio*

 ```
# Seleciona o botão de rádio com label 'Não'
test "selecionar o botão de rádio 'Não'" do
  visit formulario_path
  choose 'Não'
  click_button 'Enviar'
  assert page.has_content?('Formulário enviado com sucesso')
end
 ```

[Documentação choose](https://rubydoc.info/github/teamcapybara/capybara/master/Capybara/Node/Actions#choose-instance_method)
 
 #### check

Encontra um campo de um check box e marca-o como preenchido -  ```check([locator], **options) ```

* O método check recebe 2 argumentos: o primeiro é o elemento a ser acessado e o segundo são as opções (não é obrigatório);
* o elemento pode ser encontrado através de seu name, id, test_id attribute ou label text;
* se nenhum elemento for encontrado, ele irá marcar a si mesmo ou a um elemento filho;
* o elemento deve ser um caixa de seleção.
 
 Exemplos de testes:

*Utilizando o id do checkbox*
 ```
# Marca o checkbox com id 'checkbox_sim'
test "marcar o checkbox 'sim'" do
  visit formulario_path
  check 'checkbox_sim'
  click_button 'Enviar'
  assert page.has_content?('Formulário enviado com sucesso')
end
 ```
 
*Utilizando o nome do checkbox*

 ```
# Marca o checkbox com name 'resposta'
test "marcar o checkbox 'resposta'" do
  visit formulario_path
  check 'resposta'
  click_button 'Enviar'
  assert page.has_content?('Formulário enviado com sucesso')
end
```

*Utilizando o label do checkbox*

 ```
# Marca o checkbox com label 'Aceito os termos e condições'
test "marcar o checkbox 'Aceito os termos e condições'" do
  visit formulario_path
  check 'Aceito os termos e condições'
  click_button 'Enviar'
  assert page.has_content?('Formulário enviado com sucesso')
end

 ```

 *Marcando múltiplos checkboxes*

  ```
 # Marca múltiplos checkboxes 
test "marcar múltiplos checkboxes" do
  visit formulario_path
  check 'Aceito os termos e condições'
  check 'Desejo receber notícias por e-mail'
  click_button 'Enviar'
  assert page.has_content?('Formulário enviado com sucesso')
end
 ```
  
[Documentação check](https://rubydoc.info/github/teamcapybara/capybara/master/Capybara/Node/Actions#check-instance_method)
 
#### uncheck

Encontra um campo de um check box e marca-o como não preenchido -  ```uncheck([locator], **options) ```
 
* O método uncheck recebe 2 argumentos: o primeiro é o elemento a ser acessado e o segundo são as opções (não é obrigatório);
* o elemento pode ser encontrado através de seu name, id, test_id attribute ou label text;
* se nenhum elemento for encontrado, ele irá desmarcar a si mesmo ou a um elemento filho;
* o elemento deve ser um caixa de seleção;
* a forma de utilização se assemelha ao [check](#check), mudando apenas o nome do método.
 
Exemplo de teste:

 ```
 # Desmarca o checkbox com id 'checkbox_sim'
test "desmarcar o checkbox 'sim'" do
  visit formulario_path
  uncheck 'checkbox_sim'
  click_button 'Enviar'
  assert page.has_content?('Formulário enviado com sucesso')
end
 ```

 [Documentação uncheck](https://rubydoc.info/github/teamcapybara/capybara/master/Capybara/Node/Actions#uncheck-instance_method)
 #### attach_file

Anexa um arquivo a um campo de arquivo na página -  ```attach_file([locator], paths, **options) ``` ou  ```attach_file(paths) { ... } ```


* O método attach_file recebe três argumentos: o primeiro é o elemento a ser acessado (um campo de arquivo), o segundo é o caminho para o arquivo que será anexado, e o terceiro (opcional) são as opções;
* o campo de arquivo pode ser encontrado por seu name, id, test_id attribute, ou texto do label;
* se nenhum localizador for passado, o método tentará anexar o arquivo ao campo de arquivo atual ou a um descendente;
* nos casos em que o campo de arquivo está oculto por motivos de estilização, a opção make_visible pode ser usada para mudar temporariamente o CSS do campo de arquivo, anexar o arquivo, e depois reverter o CSS de volta ao original;

Exemplo de teste:

 ```
# Anexa um arquivo a um campo de arquivo com id 'documento'
test "anexar um documento" do
  visit formulario_path
  attach_file('documento', '/caminho/para/o/arquivo.pdf')
  click_button 'Enviar'
  assert page.has_content?('Formulário enviado com sucesso')
end
 ```

 *Até a data atual, o modo ```attach_file(paths) { ... } ``` está em beta, e por isso não iremos abordá-lo neste momento*

 [Documentação attach_file](https://rubydoc.info/github/teamcapybara/capybara/master/Capybara/Node/Actions#attach_file-instance_method)
 
 #### select

Seleciona uma opção específica de uma caixa de seleção - ```select(value = nil, from: nil, **options) ⇒ Capybara::Node::Element```

* A caixa de seleção pode ser encontrada através de seu name, id, atributo test_id ou texto do label.
* O método select pode receber até três argumentos: o valor a ser selecionado, a caixa de seleção de onde o valor deve ser selecionado e opções adicionais.
* o primeiro argumento, `value`, representa o valor que deve ser selecionado na caixa de seleção. Este argumento é obrigatório.
* o segundo argumento, `from` especifica a caixa de seleção de onde o valor deve ser selecionado. Se este argumento for omitido, a função irá procurar a opção especificada dentro do escopo atual.
* A opção dentro da caixa de seleção pode ser encontrada pelo seu texto.
* Se a caixa de seleção for do tipo de múltipla seleção, o método select pode ser chamado várias vezes para selecionar mais de uma opção.

Exemplos de testes:

*Selecionar uma opção pelo seu valor*

```
test "selecionar mês" do
  visit nova_data_path
  select 'Março', from: 'Mês'
  click_button 'Salvar'
  assert page.has_content?('Março')
end
```

*Selecionar uma opção sem especificar a caixa de seleção*

 ```
 test "selecionar mês sem especificar a caixa de seleção" do
  visit nova_data_path
  within '#data_form' do
    select 'Março'
  end
  click_button 'Salvar'
  assert page.has_content?('Março')
end
```

*Selecionar múltiplas opções*

```
test "selecionar múltiplos interesses" do
  visit novo_perfil_path
  select 'Futebol', from: 'Interesses'
  select 'Leitura', from: 'Interesses'
  click_button 'Salvar'
  assert page.has_content?('Futebol')
  assert page.has_content?('Leitura')
end
```

[Documentação select](https://rubydoc.info/github/teamcapybara/capybara/master/Capybara/Node/Actions#select-instance_method)

### Querying

Os métodos de querying servem para que possamos consultar elementos na página e validar se estão ou não estão presentes.

Existem dezenas de métodos usados para realizar essa checagem. Por conta da abrangência e das inúmeras possibilidades de mesclagem desses diferentes métodos dentro de um mesmo teste, iremos focar em exemplificar alguns, focando em sua diversidade e capacidade combinativa, ao invés de esmiuçar cada um deles.

*Para checar todos os métodos você pode acessar a [documentação](https://rubydoc.info/github/teamcapybara/capybara/master/Capybara/Node/Matchers) de **matchers** do capybara.*
 
 #### assert_text

Valida se um determinado texto está presente na página - ```assert_text([text, type], **options)``` ou ```assert_text(type, text, **options)```

* O método *assert_text* recebe até três argumentos: o texto a ser validado, o tipo de elemento em que o texto deve estar presente e opções adicionais.
* O primeiro argumento, text, representa o texto que se deseja verificar na página. Este argumento é obrigatório.
* O segundo argumento, type, é opcional e especifica o tipo de elemento HTML no qual o texto deve ser procurado. Se omitido, o Capybara procurará o texto em todo o documento HTML.
* O terceiro argumento, options, também é opcional e permite definir condições adicionais para a verificação, como o número mínimo ou máximo de ocorrências do texto.
* Note que há duas maneiras distintas de se passar os argumentos para o método, e caso apenas um argumento for passado o compilador irá assumir o uso do  primeiro modelo: ```assert_text([text, type], **options)```.
* Se o texto especificado não for encontrado na página, o teste falhará; por isso, caso queira checar se um texto **não existe** na página, utilize o método [refute_text](#refute_text), já que não é possível utilizar o retorno do método para efetuar comparações.
 
 Exemplos de testes:
 
 *Checar a presença de um texto na página*

 ```
 test "checar presença de boas vindas" do
  visit homepage_path
  assert_text 'Bem vindo ao nosso site!'
end
 ```

*Checar a presença de um texto dentro de um tipo específico de elemento*

 ```
 test "checar presença de texto em um elemento h1" do
  visit homepage_path
  assert_text 'Bem vindo ao nosso site!', type: :h1
end
```

 *Checar a presença de um texto com um número mínimo de ocorrências*

 ```
 test "checar presença de produtos na lista de produtos" do
  visit produtos_path
  assert_text 'Produto', minimum: 5
end
```
 
**Cuidados especiais com o option exact: true**

Embora seja uma opção para validar se um texto exato existe dentro da página, é uma opção difícil de lidar. O método exact cria uma string de acordo com o *type* utilizado para encontrar o *text*. Desta forma, caso exista mais de um *type*, ou seja, se ele não estiver devidamente individualizado, uma string com todos os elementos que corresponde ao type irá ser gerada, podendo fazer com que a opção tenha um comportamento inesperado.
Para evitar este cenário, é recomendado o uso de combinações de outros métodos, como por exemplo [within](#within) em conjunto com o [assert_text](#assert_text), ou assert_selector com a opção exact_text.

*Exemplo de uso de within com assert_text*
 ```
test "checar presença de texto exato dentro de um elemento específico" do
  visit homepage_path
  within '#welcome-message' do
    assert_text 'Bem vindo ao nosso site!', exact: true
  end
end
```
[Documentação assert_text](https://rubydoc.info/github/teamcapybara/capybara/master/Capybara/Node/Matchers#assert_text-instance_method)

#### refute_text

Valida se um determinado texto não está presente na página - refute_text([text, type], **options) ou refute_text(type, text, **options)

* O método refute_text é o oposto do método assert_text. Enquanto assert_text verifica a presença de um texto, refute_text verifica a ausência de um texto.
* Assim como assert_text, refute_text recebe até três argumentos: o texto a ser validado, o tipo de elemento em que o texto deve estar presente e opções adicionais.
* O primeiro argumento, text, representa o texto que se espera não encontrar na página. Este argumento é obrigatório.
* O segundo argumento, type, é opcional e especifica o tipo de elemento HTML no qual o texto deve ser procurado. Se omitido, o Capybara procurará o texto em todo o documento HTML.
* O terceiro argumento, options, também é opcional e permite definir condições adicionais para a verificação, como o número mínimo ou máximo de ocorrências do texto.
* Note que há duas maneiras distintas de se passar os argumentos para o método, e caso apenas um argumento for passado o compilador irá assumir o uso do primeiro modelo: refute_text([text, type], **options).
* Se o texto especificado for encontrado na página, o teste falhará.
* Também pode ser utilizado como *assert_no_text*.
 
Exemplos de testes:

*Checar a ausência de um texto na página*

 ```
test "checar ausência de mensagem de erro" do
  visit homepage_path
  refute_text 'Erro!'
end
 ```

*Checar a ausência de um texto dentro de um tipo específico de elemento*

 ```
test "checar ausência de texto em um elemento h1" do
  visit homepage_path
  refute_text 'Erro!', type: :h1
end
 ```

*Checar a ausência de um texto com um número máximo de ocorrências*

 ```
test "checar ausência de produtos na lista de produtos" do
  visit produtos_path
  refute_text 'Produto', maximum: 0
end
```
 
[Documentação refute_text](https://rubydoc.info/github/teamcapybara/capybara/master/Capybara/Minitest/Assertions#refute_text-instance_method)
 
#### outros métodos de match

Os métodos que começam com assert_ e refute_ (ou has_ e has_no_) são muito semelhantes - eles fazem afirmações sobre a presença ou ausência de um determinado elemento, texto ou condição. A diferença entre eles geralmente reside no que exatamente eles estão verificando (texto, CSS, XPath, etc.) e como eles esperam que esses elementos sejam passados (como um seletor CSS, XPath, etc.).

Uma grande diferença entre os métodos que começam com *assert_/ refute_* e os que começam com  *has_/has_no_* é que enquanto os primeiros fazem com que o teste falhe caso as condições não sejam atendidas, os segundos apenas retornam valores de *true* ou *false* a depender da presença do elemento que está sendo verificado, e por isso pode ser encadeado em condicionais ou mesmo loops.

Os métodos que terminam em _selector estão verificando a presença ou ausência de um determinado seletor (como um seletor CSS ou XPath), enquanto aqueles que terminam em _text estão verificando a presença ou ausência de um determinado texto (como os métodos [assert_text](#assert_text) e [refute_text](#refute_text)).

Os métodos que terminam em _field ou _button ou _link são métodos específicos para verificar a presença ou ausência de um determinado campo de formulário, botão ou link, respectivamente.

E, finalmente, os métodos que começam com matches_ estão verificando se um determinado elemento corresponde a um seletor ou condição específica.

É possível checar a quase todos os métodos de *matchers* disponíveil no [site do rubydoc](https://rubydoc.info/github/teamcapybara/capybara/master/Capybara/Node/Matchers).

### Finders

Os finders são métodos especializados em encontrar elementos na página. Os elementos podem ser genéricos, ou seja, o método irá procurar por qualquer elemento que atenda as especificações do parâmetro passado para o método, ou pode ser específico, como por exemplo o método find_button, que irá procurar e retornar um elemento do tipo botão.

#### find_all

O método find_all, ou simplesmente all, retorna todos os elementos presentes na página que correspondem aos parâmetros passados. ```all([kind = Capybara.default_selector], locator = nil, **options)``` ou ```all([kind = Capybara.default_selector], locator = nil, **options) {|element| ... } ```
 
 * O método recebe 3 argumentos, sendo apenas um obrigatório: o elemento a ser procurado.
 * Por padrão, caso apenas 1 argumento seja passado, o método irá procurar por elementos de *CSS*, mas o tipo também pode ser *Xpath*, e portanto um elemento pode ser encontrado pelo seu id.
 * Ao encontrar diversos elementos, todos serão salvos dentro de um array de objetos.
 
Exemplos de testes:

 *Utilizar o retorno da função para verificar cada elemento dentro do array*

 ```
 test "verificar se todos os parágrafos contém um texto" do
  visit root_path
  paragraphs = all('p')
  paragraphs.each do |paragraph|
    assert_text paragraph.text, type: :p
  end
end
  ```

 *Checar o tamanho do array para verificar quantos elementos de erro existem*

 ```
test "verificar se existem mais de 3 elementos com o id 'error'" do
  visit root_path
  error_elements = all('#error')
  assert(error_elements.size <= 3, "Mais de três elementos com o id 'error' foram encontrados")
end
 ```

 [Documentação find_all](https://rubydoc.info/github/teamcapybara/capybara/master/Capybara/Node/Finders#all-instance_method)
                                 
#### find
                                 
O método find retorna o primeiro elemento que corresponde aos parâmetros passados - ``` find([kind = Capybara.default_selector], locator, **options) ```

* O método recebe 3 argumentos, sendo apenas um obrigatório: o elemento a ser procurado.
* Por padrão, caso apenas 1 argumento seja passado, o método irá procurar por elementos de CSS, mas o tipo também pode ser XPath, e portanto um elemento pode ser encontrado pelo seu id.
* Ao contrário do find_all, find retornará o primeiro elemento que corresponder ao seletor fornecido; além disto,  caso mais de um elemento seja encontrado, um erro de "ambiguous match" será levantado.
                           
Exemplos de testes:

*Verificar se um elemento com um determinado ID contém um texto específico* 
                                 
```
test "verificar se o elemento com o id 'welcome' contém o texto 'Bem-vindo!'" do
  visit pagina_inicial_path
  welcome_element = find('#welcome')
  assert_text 'Bem-vindo!', welcome_element.text
end
```
       
*Verificar se um elemento com um determinado CSS contém um texto específico*
                                 
```
test "verificar se o primeiro parágrafo contém o texto 'Olá, Mundo!'" do
  visit pagina_inicial_path
  first_paragraph = find('p')
  assert_text 'Olá, Mundo!', first_paragraph.text
end
```
                                 
[Documentação find](https://rubydoc.info/github/teamcapybara/capybara/master/Capybara/Node/Finders#find-instance_method)
                                 
#### outros métodos de finders

**ancestor**
                                 
O método ancestor é usado para encontrar um elemento que seja ancestral do elemento atual. É útil quando você precisa navegar na estrutura do DOM em relação ao elemento atual.

**find_by_id**
                                 
O método find_by_id é usado para encontrar um elemento na página, dado o seu ID. Este método é útil quando você precisa interagir com um elemento que tem um ID único.

**find_field**
                                 
O método find_field é usado para encontrar um campo de formulário na página. Isso pode ser útil quando você precisa interagir com campos de formulário específicos, como caixas de texto, caixas de seleção, botões de rádio, etc.

**find_link**
                                 
O método find_link é usado para encontrar um link na página. Isso pode ser útil quando você precisa interagir com um link específico.

**first**
                                 
O método first é usado para encontrar o primeiro elemento na página que corresponde aos parâmetros passados. É semelhante ao método find, mas não lança um erro se houver mais de um elemento correspondente.

**sibling**
                                 
O método sibling é usado para encontrar um elemento que seja um irmão do elemento atual. Isso é útil quando você precisa interagir com elementos que estão no mesmo nível na estrutura do DOM.
                                 
Para checar como utilizar cada um deles, veja a [documentação](https://rubydoc.info/github/teamcapybara/capybara/master/Capybara/Node/Finders).
                                 
### Scoping

Pelo que vimos anteriormente, pudemos constatar que existem diversos métodos que conseguem encontrar, selecionar e retornar um ou mais elementos de uma página. Em geral, os métodos procuram dentro de toda a página atual por tais elementos, o que pode acabar atrapalhando em casos específicos de testes, como por exemplo um teste onde existem N números de elementos iguais espalhados por diferentes contextos, sem que haja uma identificação individualizada de cada um deles. 
Diante deste cenário, os métodos de escopo permitem que trabalhemos dentro de um local específico dentro do nosso DOM, e resolvamos problemas de ambiguidade e individualização de elementos.
                                 
#### within
                                 
O método within, ou within_element, é um método genérico de escopo com o qual conseguimos fazer um recorte do HTML de acordo com os parâmetros passados- ```within(*find_args)``` ou ``` within(a_node)```

* Embora a documentação não traga em seu protótipo, o método *within* aceita 2 parâmetros. O primeiro parâmetro é o tipo de elemento que irá identificar a busca (XPath ou CSS), e o segundo o elemento a ser procurado.
* Por padrão, caso apenas um argumento seja passado, o elemento será buscado como CSS.
* Caso mais de um elemento seja encontrado, um erro de ambiguidade será levantado.
* Diferentemente dos outros seletores, ao invés de retornar um elemento, o método within dee ser chamado para executar um bloco de código dentro de seu contexto.

Exemplos de testes: 

*Utilizando within para encontrar um texto dentro de um campo específico*
                                 
```
test "verificar se o elemento dentro de um div específico contém o texto 'Bem-vindo!'" do
  visit root_path
  within('div#welcome-div') do
    assert_text 'Bem-vindo!'
  end
end
```

*Utilizando within para individualizar os campos de um formulário*

```
test "preencher um formulário dentro de um div específico" do
  visit pagina_formulario_path
  within('div#form-div') do
    fill_in 'Nome', with: 'Meu nome'
    fill_in 'Email', with: 'meuemail@email.com'
    click_button 'Enviar'
  end
end
```

*Utilizando within em conjunto com múltiplos elementos no bloco*

```
test "verificar se todos os elementos de lista dentro de uma lista ordenada específica têm o texto correto" do
  visit pagina_lista_path
  within('ol#minha-lista') do
    assert_text 'Item 1', within: 'li#item-1'
    assert_text 'Item 2', within: 'li#item-2'
    assert_text 'Item 3', within: 'li#item-3'
  end
end
```

[Documentação within](https://rubydoc.info/github/teamcapybara/capybara/master/Capybara/Session#within-instance_method)

#### Outros métodos de Scoping

**within_fieldset**

Este método permite especificar um escopo dentro de um conjunto de campos (fieldset) em um formulário. Isto é particularmente útil quando trabalhamos com formulários complexos que possuem múltiplos conjuntos de campos.   
             
```
within_fieldset('Detalhes do Contato') do
  fill_in 'Email', with: 'contato@example.com'
end
```

[Documentação within_fieldset](https://rubydoc.info/github/teamcapybara/capybara/master/Capybara%2FSession:within_fieldset)                   

**within_table**

Similar ao within_fieldset, este método permite especificar um escopo dentro de uma tabela. Isto pode ser útil quando formos trabalhar com páginas que possuem tabelas complexas.

```
within_table('Tabela de Produtos') do
  assert_text 'Produto A'
end
```                                

[Documentação within_table](https://rubydoc.info/github/teamcapybara/capybara/master/Capybara%2FSession:within_frame)                          

**within_window**

Este método é usado para especificar um escopo dentro de uma janela ou aba específica do navegador. Isto é especialmente útil ao trabalhar com testes que envolvem a interação com múltiplas janelas ou abas.  

```
new_window = window_opened_by { click_link 'Abrir em nova aba' }
within_window new_window do
  assert_text 'Esta é uma nova aba'
end
```

[Documentação within_window](https://rubydoc.info/github/teamcapybara/capybara/master/Capybara%2FSession:within_window)
                                 
### Modais

O capybara também nos permite interagir com modais com métodos específicos. Ao invés de tratá-los como janelas, é possível utilizar os métodos de modal e desta forma aceitar, recusar ou fechar modais com grande facilidade.

#### accept_alert

O método *accept_alert* é usado para interagir com um alerta JavaScript (modal) em uma página e aceitá-lo - ```accept_alert(text, **options)``` ou ```accept_alert(**options)```

* Este método executa um bloco de código e, em seguida, aceita qualquer alerta que tenha sido aberto durante a execução do bloco.
* O método aceita um parâmetro opcional, que é o texto esperado no alerta. Se um texto é fornecido e o texto do alerta não corresponde, um erro será levantado.
* É importante notar que o accept_alert só funcionará com alertas JavaScript simples - não funcionará com confirmations ou prompts, para os quais existem métodos separados.

Exemplos de testes:

*Utilizando o accept_alert para excluir um item após abrir um modal*

```
test "aceitar alerta após clicar no botão 'Excluir'" do
  visit pagina_produtos_path
  accept_alert do
    click_button 'Excluir'
  end
  assert_text 'O item foi excluído com sucesso'
end
```

*Utilizando o accept_alert para excluir um item após abrir um modal com um texto específico. Caso o texto não exista, um erro será levantado*

```
test "aceitar alerta com texto esperado após clicar no botão 'Excluir'" do
  visit pagina_inicial_path
  accept_alert('Tem certeza de que deseja excluir este item?') do
    click_button 'Excluir'
  end
  assert_text 'O item foi excluído com sucesso'
end
```

[Documentação accept_alert](https://rubydoc.info/github/teamcapybara/capybara/master/Capybara/Session:accept_alert)   
                                 
#### dismiss_confirm

O método *dismiss_confirm* é usado para interagir com uma janela de confirmação JavaScript (modal) em uma página  - 
```dismiss_confirm(text, **options) ``` ou ``` dismiss_confirm(**options)```

*Este método executa um bloco de código e, em seguida, rejeita qualquer confirmação que tenha sido aberta durante a execução do bloco.
*O método aceita um parâmetro opcional, que é o texto esperado na janela de confirmação. Se um texto é fornecido e o texto da confirmação não corresponder, um erro será levantado.
*É importante notar que o `dismiss_confirm` só funcionará com confirmações JavaScript - não funcionará com alertas ou prompts, para os quais existem métodos separados.

Exemplos de testes:

*Utilizando o dismiss_confirm rejeitar a exclusão excluir de um item após abrir um modal*

```
test "rejeitar confirmação após clicar no botão 'Excluir'" do
  visit pagina_inicial_path
  dismiss_confirm do
    click_button 'Excluir'
  end
  assert_no_text 'O item foi excluído com sucesso'
end
``` 

*Utilizando o dismiss_confirm rejeitar a exclusão excluir de um item após abrir um modal com um texto específico*

``` 
test "rejeitar confirmação com texto esperado após clicar no botão 'Excluir'" do
  visit pagina_inicial_path
  dismiss_confirm('Tem certeza de que deseja excluir este item?') do
    click_button 'Excluir'
  end
  assert_no_text 'O item foi excluído com sucesso'
end
``` 

[Documentação dismiss_confirm](https://rubydoc.info/github/teamcapybara/capybara/master/Capybara/Session:dismiss_confirm)

#### accept_prompt

O método *accept_prompt* é usado para interagir com uma caixa de diálogo JavaScript (prompt) em uma página - `accept_prompt(text, **options)` 

* Este método executa um bloco de código e, em seguida, aceita qualquer prompt que tenha sido aberto durante a execução do bloco.
* O método pode aceitar até dois parâmetros opcionais. O primeiro é o texto esperado no prompt, e o segundo é a resposta que você deseja dar ao prompt. Se o texto do prompt não corresponder ao texto fornecido, um erro será levantado.
* É importante notar que o `accept_prompt` só funcionará com prompts JavaScript - não funcionará com alertas ou confirmações, para os quais existem métodos separados (`accept_alert`,  `dismiss_confirm`).

Exemplos de testes:

```
test "aceitar prompt após clicar no botão 'Mudar Nome'" do
  visit pagina_inicial_path
  accept_prompt with: 'Novo Nome' do
    click_button 'Mudar Nome'
  end
  assert_text 'O nome foi alterado para Novo Nome'
end
```

[Documentação accept_prompt](https://rubydoc.info/github/teamcapybara/capybara/master/Capybara/Session:accept_prompt)
                                 
### Debug

O capybara por padrão fornece algumas formas de debugar o código mesmo sem precisar de métodos específicos.

Em primeiro lugar, sempre que um teste falhar durante a execução, uma *screenshot* será salva dentro da pasta `/tmp/screenshots/failures_test_{nome_do_teste}.png`. Este endereço será mostrado no início do teste, antes mesmo da mensagem de erro.

Além disso, as mensagens de erro serão descritivas seguindo o padrão:

```
Error:
Nome_da_classe_de_teste#Nome_do_teste:
Classe_da_exceção: descrição do erro
    caminho_arquivo_teste:linha_do_erro <bloco do erro>
```
    
Abaixo está uma imagem de exemplo da descrição de um erro:

![image](https://github.com/Phill9242/capybara_tests/assets/85121830/ea21dc39-cbe3-4e48-8b1a-16cbf45d2620)

* **Screenshot image:** o caminho para a imagem gerada da tela quando o erro aconteceu.
* **ProdutoTest#test_visitar_a_página_de_cadastrar_novo_produto:** O nome da classe do teste e o nome do teste, respectivamente, separados por uma hashtag.
* **Capybara:ambiguous:** classe da exceção levantada.
* **Ambiguous match, found 5 elements matching visible css "div.row":** A descrição do erro. Neste caso, era esperado que apenas um elemento fosse encontrado ao utilizar o teste "find", no entanto 5 elementos foram encontrados, e isso resultou em um erro.
* **test/system/cadastro_produtos_test.rb:16:in `block in <class:ProdutosTest>':** caminho para encontrar o arquivo e a linha de código que gerou o erro.         

Por fim, é importante notar que a depender do tempo para os testes serem executados, alguns comportamentos podem variar de acordo com o ambiente em que os testes estão sendo executados. Isto porque, ao lidar com processos assíncronos ao executar scripts na página, o tempo de resposta para renderizar determinada página pode ultrapassar o limite de 2 segundos colocados por padrão. Esses erros podem ser comuns ao tentar verificar elementos após clicar em um botão que renderiza a página, carrega elementos, etc. Talvez seja necessário aumentar o tempo de resposta dentro da sua [configuração](#configuração-capybara), modificando o tempo limite de resposta, como no exemplo abaixo, onde o tempo máximo de espera foi modificado pra 5 segundos:

```
require 'capybara/rails'

Capybara.configure do |config|
  # outras configurações ...
  Capybara.default_max_wait_time = 5
end
```
*Para mais informações a respeito de scripts assíncronos no capybara, acessa a [documentação](https://github.com/teamcapybara/capybara#asynchronous-javascript-ajax-and-friends)*

Mesmo com essas ferramentas auxiliares, algumas vezes será necessário verificar a etapa anterior à qual estamos para encontrar o motivo que fez com que o teste funcionasse quando deveria falhar, ou falhar quando tudo parece indicar que não há erros. Para estes cenários, os métodos a seguir setão úteis para fazer essas verificações:

#### save_and_open_page

Este método nos permite tirar um snapshot de determinada página, salvá-lo e abrir - ```save_and_open_page(path = nil)```

* Recebe um único parâmetro: o caminho onde o arquivo deverá ser salvo.
* Caso nenhum argumento seja passado, utiliza o caminho padrão com um nome de arquivo aleatório (/temp/capybara).
* O nome do arquivo gerado e o caminho para o mesmo são mostrados no terminal durante a execução dos testes.
* O documento HTML será gerado de acordo com as interações de outros métodos até a chamada do método save_and_open_page, tornando possível checar como a página se comporta e renderiza após a chamada de cada método.

Exemplo de teste:

*Salva um arquivo HTML com o estado dos elementos após clicar em um botão*

``` 
test "abrir a página após clicar no botão 'Enviar'" do
  visit formulario_path
  click_button 'Enviar'
  save_and_open_page
end
``` 

[Documentação save_and_open_page](https://rubydoc.info/github/teamcapybara/capybara/master/Capybara/Session:save_and_open_page)

#### save_screenshot

Este método é similar ao [save_and_open_page](#save_and_open_page), mas ao invés de salvar um snapshot, ele salva uma screenshot da tela. Desta forma é melhor utilizado para verificar bug's puramente visuais e até mesmo o comportamento de diferentes navegadores com determinado código HTML - ```save_screenshot(path = nil, **options)```.

* Apesar de receber 2 argumentos, nenhum é obrigatório.
* Caso nenhum argumento seja passado, utiliza o caminho padrão com um nome de arquivo aleatório (/temp/capybara).

Exemplo de teste:

*Tira um screenshot e o salva no formato .png no clicar em um botão*

``` 
test "abrir a página após clicar no botão 'Enviar'" do
  visit formulario_path
  click_button 'Enviar'
  save_screenshot
end
``` 

[Documentação save_screenshot](https://rubydoc.info/github/teamcapybara/capybara/master/Capybara/Session:save_screenshot)
___

## Testando uma aplicação

Agora que configuramos nossa aplicação e aprendemos sobre a DSL do Capybara, podemos dar início à criação de testes.

Em primeiro lugar, é necessário deixar claro que o objetivo do Capybara e deste Guia não é abordar os diferentes tipos de testes, mas sim focarmos nos testes ponta a ponta (end to end), mais espeficicamente na interação do usuário com a aplicação, ou seja, estamos no topo da [**pirâmide de testes**](https://blog.onedaytesting.com.br/piramide-de-teses/)

### Diretrizes gerais

É importante que 



