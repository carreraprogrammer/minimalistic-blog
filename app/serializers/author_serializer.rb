class AuthorSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :photo, :bio, :posts_counter, :created_at, :updated_at
  has_many :posts
end
