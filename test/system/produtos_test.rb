require "application_system_test_case"

class ProdutosTest < ApplicationSystemTestCase
  setup do
    @produto1 = produtos(:one)
    @produto2 = produtos(:two)
  end

  test "visitar página produtos / home" do
    visit root_path
    assert_selector "h3", text: "Produtos"
  end

  test "checar exibição das fixtures" do
    visit root_path

    within(".produto-#{@produto1.nome}") do
      assert_text @produto1.nome
      assert_text @produto1.descricao
      assert_text @produto1.departamento.nome
      assert_text @produto1.preco
      assert_text @produto1.quantidade
    end

    within(".produto-#{@produto2.nome}") do
      assert_text @produto2.nome
      assert_text @produto2.descricao
      assert_text @produto2.departamento.nome
      assert_text @produto2.preco
      assert_text @produto2.quantidade
    end
  end

  test "visitar a página de cadastrar novo produto" do
    visit new_produto_path

    assert_text "Nome"
    assert_text "Descrição"
    assert_text "Departamento"
    assert_text "Preço"
    assert_text "Quantidade"

  end

  test "cadastrar produto sem preencher os dados" do
    visit new_produto_path

    click_on "Criar"

    assert_text "Preco não pode ficar em branco"
    assert_text "Nome é muito curto (mínimo: 3 caracteres)"
    assert_text "Quantidade não pode ficar em branco"
    
  end

  test "cadastrar produto sem preencher Nome e Quantidade" do
    visit new_produto_path

    find(".preco").set(@produto1.preco)
    
    click_on "Criar"

    refute_text "Preco não pode ficar em branco"
    assert_text "Nome é muito curto (mínimo: 3 caracteres)"
    assert_text "Quantidade não pode ficar em branco"
    
  end


  test "cadastrar produto colocando Preço com letras e sem preencher outros campos" do
    visit new_produto_path

    find(".preco").set(@produto1.nome)
    
    click_on "Criar"

    assert_text "Preco não pode ficar em branco"
    assert_text "Nome é muito curto (mínimo: 3 caracteres)"
    assert_text "Quantidade não pode ficar em branco"
    
  end

  test "cadastrar produto colocando com nome de 2 letras" do
    visit new_produto_path

    fill_in "nome", with: "ab"
    fill_in "produto_preco", with: @produto1.preco
    fill_in "produto_quantidade", with: @produto1.quantidade
    
    click_on "Criar"

    assert_text "Nome é muito curto (mínimo: 3 caracteres)"
    refute_text "Preco não pode ficar em branco"
    refute_text "Quantidade não pode ficar em branco"
    
  end
  
  test "cadastrar produto colocando com nome de 2 letras sem preencher os outros campos" do
    visit new_produto_path

    fill_in "nome", with: "ab"
    
    click_on "Criar"

    assert_text "Preco não pode ficar em branco"
    assert_text "Nome é muito curto (mínimo: 3 caracteres)"
    assert_text "Quantidade não pode ficar em branco"
    
  end

end