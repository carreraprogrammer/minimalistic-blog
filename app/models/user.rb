class User < ApplicationRecord
  has_many :posts, dependent: :destroy, foreign_key: :author_id
  has_many :comments
  has_many :likes
end
