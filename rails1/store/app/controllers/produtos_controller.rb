class ProdutosController < ApplicationController

    def index
        @produtos = Produto.order :nome
        @produto_com_desconto = Produto.order(:preco).limit 1
    end

    def create
        produto_params = params.require(:produto).permit(:nome, :descricao, :preco, :quantidade)
        
        @produto = Produto.new produto_params

        if @produto.save
            flash[:notice] = "Produto salvo"
        end
        render :new
    end
      

    def destroy
        id = params.require(:id)
        Produto.destroy id
        redirect_to root_path
    end

    def busca
        @nome = params[:nome]
        @produtos = Produto.where "nome like ?", "%#{@nome}%"
    end
end
