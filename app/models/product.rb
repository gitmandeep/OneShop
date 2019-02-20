class Product < ApplicationRecord
  # mount_uploader :picture, PictureUploader
  has_many_attached :pictures

  paginates_per 9

  belongs_to :category

  has_many :comments, dependent: :destroy

  has_many :carts_products, dependent: :destroy
  has_many :carts, through: :carts_products 

  validates :name, :description, :price, :pictures, :category_id, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 1 }

end
