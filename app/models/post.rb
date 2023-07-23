class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  has_many :comments, dependent: :destroy, foreign_key: :post_id
  has_many :likes, dependent: :destroy, foreign_key: :post_id
  after_save :update_posts_counter
  after_destroy :decrease_posts_counter
  validates :title, presence: true
  validates :title, length: { maximum: 250 }
  validates :comments_counter, numericality: { greater_than_or_equal_to: 0 }
  validates :comments_counter, numericality: { only_integer: true }
  validates :likes_counter, numericality: { greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true }

  def update_posts_counter
    author.increment!(:post_counter)
  end

  def recent_comments
    comments.includes!(:author).order(created_at: :asc).limit(5)
  end

  def decrease_posts_counter
    author.decrement!(:post_counter)
  end
end
