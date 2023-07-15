class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  has_many :comments, dependent: :destroy, foreign_key: :post_id
  has_many :likes, dependent: :destroy, foreign_key: :post_id

  def update_posts_count
    author.increment(:post_counter)
  end

  def recent_comments
    comments.includes(:author).order(created_at: :desc).limit(5)
  end
end
