class User < ApplicationRecord
  has_many :posts, dependent: :destroy, foreign_key: :author_id
  has_many :comments
  has_many :likes
  validates :name, presence: true
  validates :post_counter, numericality: { greater_than_or_equal_to: 0 }
  validates :quantity, numericality: { only_integer: true }

  def recent_posts
    posts.includes(:author).order(created_at: :desc).limit(3)
  end
end
