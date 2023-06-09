
# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  resources :departamentos
  resources :produtos, only: [:new, :create, :destroy, :edit, :update]
  root to: "produtos#index"
  get "produtos/busca", to: "produtos#busca", as: :busca_produto
end