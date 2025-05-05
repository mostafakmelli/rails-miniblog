module Types
  class PostType < BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :content, String, null: false
    field :published_at, GraphQL::Types::ISO8601DateTime, null: true
  end
end
