class Product < ApplicationRecord
  mount_uploader :picture, PictureUploader

  paginates_per 9

  belongs_to :category

  has_many :comments
  has_many :carts_products
  has_many :carts, through: :carts_products 

  validates :name, :description, :price, :picture, :category_id, presence: true
end
