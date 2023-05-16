class Produto < ApplicationRecord
    validates :preco, presence: true
    validates :nome, length: { minimum: 3 }
    validates :quantidade, presence: true
    belongs_to :departamento, optional: true
end
