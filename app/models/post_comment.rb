class PostComment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  # has_many :likes, dependent: :destroy
  
  validates :comment, presence: true
end
