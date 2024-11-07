class Post < ApplicationRecord
  validates :user_id,  presence: true
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :post_comments, dependent: :destroy

  def liked_by?(user)
    # 存在するかどうか
    likes.exists?(user_id: user.id)
  end
end
