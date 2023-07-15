class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  has_many :comments, dependent: :destroy, foreign_key: :post_id
  has_many :likes, dependent: :destroy, foreign_key: :post_id
  after_save :update_posts_counter
  after_destroy :decrease_posts_counter

  def update_posts_counter
    author.increment!(:post_counter)
  end

  def recent_comments
    comments.includes(:author).order(created_at: :desc).limit(5)
  end

  def decrease_posts_counter
    author.decrement!(:post_counter)
  end
end
