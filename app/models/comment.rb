class Comment < ApplicationRecord
  belongs_to :product
  belongs_to :user  
  validates :your_comment, format: {with: /\A[a-zA-Z]+\z/, message:"only letters allow"}, presence:true

  delegate :first_name, :dob, :last_name, :to => :user, :prefix => true
end
