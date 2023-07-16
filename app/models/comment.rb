class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  belongs_to :post
  after_save :update_comments_counter
  after_destroy :decrease_comments_counter
  validates :text, presence: true, length: { in: 2..100 }

  def update_comments_counter
    post.increment!(:comments_counter)
  end

  def decrease_comments_counter
    post.decrement!(:comments_counter)
  end
end
