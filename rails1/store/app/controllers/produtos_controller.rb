class ProdutosController < ApplicationController

    def index
        @produtos = Produto.order :nome
        @produto_com_desconto = Produto.order(:preco).limit 1
    end

    def create
        produto_params = params.require(:produto).permit(:nome, :descricao, :preco, :quantidade, :departamento_id)
        
        @produto = Produto.new produto_params
        @departamentos = Departamento.all
        if @produto.save
            redirect_to root_path
        else
            render :new
        end
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

    def new
        @produto = Produto.new
        @departamentos = Departamento.all
    end

    def edit
        id = params[:id]
        @produto = Produto.find(id)
        @departamentos = Departamento.all
        render :new
    end

    def update
        id = params[:id]
        @produto = Produto.find(id)
        novos_params = params.require(:produto).permit(:nome, :descricao, :preco, :quantidade, :departamento_id)
        if @produto.update novos_params
            flash[:notice] = "Produto atualizado"
            redirect_to root_path
        else
            @departamentos = Departamento.all
            render :new
        end
    end
end
