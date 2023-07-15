class User < ApplicationRecord
  has_many :posts, dependent: :destroy, foreign_key: :author_id
  has_many :comments
  has_many :likes
  validates :name, presence: true

  def recent_posts
    posts.includes(:author).order(created_at: :desc).limit(3)
  end
end
