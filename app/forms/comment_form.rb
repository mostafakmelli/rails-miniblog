class CommentForm < Dry::Rails::Form
  attribute :user_id, Types::Params::Integer
  attribute :body,    Types::Params::String
  attribute :commentable_type, Types::Params::String
  attribute :commentable_id,   Types::Params::Integer

  validates :body, filled?: true, min_size?: 5
end
