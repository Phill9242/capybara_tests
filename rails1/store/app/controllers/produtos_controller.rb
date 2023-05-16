class ProdutosController < ApplicationController

    def index
        @produtos = Produto.order :nome
        @produto_com_desconto = Produto.order(:preco).limit 1
    end

    def create
        produto = params[:id]
        Produto.create produto
        redirect_to root_path
    end

    def destroy
        id = params.require(:id)
        Produto.destroy id
        redirect_to root_path
    end
end
