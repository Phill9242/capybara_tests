require "application_system_test_case"

class DepartamentosTest < ApplicationSystemTestCase
  setup do
    @departamento = departamentos(:one)
  end

  test "visitar página departamentos" do
    visit departamentos_url
    assert_selector "h1", text: "Departamentos"
  end

  test "creating a Departamento" do
    visit departamentos_url
    click_on "Novo Departamento"

    fill_in "Nome", with: @departamento.nome
    click_on "Criar Departamento"

    assert_text "Departamento was successfully created"
    click_on "Voltar"
  end

  test "updating a Departamento" do
    visit departamentos_url
    click_on "Editar", match: :first

    fill_in "departamento_nome", with: @departamento.nome
    click_on "Atualizar Departamento"

    assert_text "Departamento was successfully updated"
    click_on "Voltar"
  end

  test "deletar um Departamento" do
    visit departamentos_url
    page.accept_confirm do
      click_on "Remover", match: :first
    end

    assert_text "Departamento was successfully destroyed"
  end
end
