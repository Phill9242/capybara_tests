
# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
    resources :produtos, only: [:new, :create, :destroy]
    root to: "produtos#index"
    get "produtos/busca", to: "produtos#busca", as: :busca_produto
end