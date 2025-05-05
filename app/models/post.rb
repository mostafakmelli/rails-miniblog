class Post < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  scope :published, -> { where.not(published_at: nil) }
end
