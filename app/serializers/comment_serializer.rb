class CommentSerializer < ActiveModel::Serializer
  attributes :id, :text, :created_at, :updated_at, :post_id, :author_id
  belongs_to :post_id
end
