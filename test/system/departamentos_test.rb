# require "application_system_test_case"

# class DepartamentosTest < ApplicationSystemTestCase
#   setup do
#     @departamento = departamentos(:one)
#     @departamento2 = departamentos(:two)
#   end

#   test "visitar página departamentos" do
#     visit departamentos_url
#     assert_selector "h1", text: "Departamentos"
#   end

#   test "Criar um Departamento" do
#     visit departamentos_url
#     click_on "Novo Departamento"

#     fill_in "departamento_nome", with: "Eletrônicos"
#     click_on "Criar Departamento"

#     assert_text "Departamento was successfully created."
#     click_on "Voltar"

#     assert_selector ".nome_departamento", text: "Eletrônicos"
#   end

#   test "Atualizar um Departamento" do
#     nome_atualizado = "Nome Unico de Registro teste"

#     visit departamentos_url
#     within('.departamento-mystring') do
#       click_on "Editar"
#     end

#     fill_in "departamento_nome", with: nome_atualizado
#     click_on "Atualizar Departamento"

#     assert_text "Departamento was successfully updated"
#     click_on "Voltar"

#     assert_selector ".nome_departamento", exact_text: nome_atualizado
#   end

#   test "Atualizar o departamento mystring2" do
#     nome_atualizado = "Nome Unico de Registro teste"
    
#     visit departamentos_url
  
#     within('.departamento-mystring') do
#       click_on "Editar"
#     end
  
#     fill_in "departamento_nome", with: nome_atualizado
#     click_on "Atualizar Departamento"
  
#     assert_text "Departamento was successfully updated"
#     click_on "Voltar"
  
#     assert_selector ".nome_departamento", exact_text: nome_atualizado
#   end

#   test "deletar um Departamento" do
#     visit departamentos_url
#     page.accept_confirm do
#       click_on "Remover", match: :first
#     end

#     assert_text "Departamento was successfully destroyed"
#   end

# end
