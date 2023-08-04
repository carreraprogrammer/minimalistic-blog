class PostSerializer < ActiveModel::Serializer
  belongs_to :author_id
  attributes :id, :title, :text, :comments_counter, :likes_counter, :created_at, :updated_at, :author_id
  has_many :comments
end
