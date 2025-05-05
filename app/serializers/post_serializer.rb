class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :published_at
  belongs_to :user
  belongs_to :category
  has_many :tags
  has_many :comments
end
