class Like < ApplicationRecord
  has_many :posts, dependent: :destroy, foreign_key: :author_id
  has_many :likes, dependent: :destroy
  after_save :update_comments_counter
  after_destroy :decrease_comments_counter

  def update_comments_counter
    post.increment!(:likes_counter)
  end

  def decrease_likes_counter
    post.decrement!(:likes_counter)
  end
end
