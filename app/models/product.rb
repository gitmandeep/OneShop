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
  validate :white_list

  # def to_param
  #   name
  # end
  def to_param
    "#{id}-#{name}".parameterize
    #[id, name.parameterize].join("-")
  end

  def white_list
  	pictures.each do |picture|
	  	if !picture.content_type.in?(%w(image/jpeg image/png image/jpg))
	      errors.add(:pictures, 'Must be a of jpeg, jpg or png format')
	    end
		end
  end

  def self.search(search)
    where("name LIKE ? OR description LIKE ? ", "%#{search}%", "%#{search}%") 
  end
end
