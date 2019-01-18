class Comment < ApplicationRecord
  belongs_to :product
  belongs_to :user  
  validates :your_comment, presence:true

  delegate :first_name, :dob, :last_name, :to => :user, :prefix => true
end
