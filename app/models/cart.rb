class Cart < ApplicationRecord
  belongs_to :user,    dependent: :destroy
  has_many :carts_products
  has_many :products, through: :carts_products
end