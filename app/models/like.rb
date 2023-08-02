class Like < ApplicationRecord
  belongs_to :post, foreign_key: :post_id
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  after_save :update_likes_counter

  def update_likes_counter
    post.increment!(:likes_counter)
  end

  def decrease_likes_counter
    post.decrement!(:likes_counter)
  end
end
