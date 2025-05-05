class PostForm < Dry::Rails::Form
  attribute :user_id, Types::Params::Integer
  attribute :title,   Types::Params::String
  attribute :content, Types::Params::String
  attribute :category_id, Types::Params::Integer
  attribute :tag_ids, Types::Params::Array.of(Types::Params::Integer)

  validates :title, filled?: true, min_size?: 5
  validates :content, filled?: true, min_size?: 20
  validates :category_id, filled?: true
end
