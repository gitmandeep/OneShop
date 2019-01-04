class Comment < ApplicationRecord
  belongs_to :product, dependent: :destroy
  belongs_to :user, dependent: :destroy, required: false

  validates :your_comment, format: {with: /\A[a-zA-Z]+\z/, message:"only letters allow"}, presence:true

  delegate :first_name, :dob, :last_name, :to => :user, :prefix => true
end
