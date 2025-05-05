module Types
  class QueryType < Types::BaseObject
    field :posts, [PostType], null: false do
      argument :published_only, Boolean, required: false, default_value: true
    end
    def posts(published_only: true)
      scope = published_only ? Post.published : Post.all
      scope.order(published_at: :desc)
    end

    field :post, PostType, null: true do
      argument :id, ID, required: true
    end
    def post(id:)
      Post.find_by(id: id)
    end

    field :users, [UserType], null: false
    def users
      User.all
    end

    field :categories, [CategoryType], null: false
    def categories
      Category.all
    end

    field :tags, [TagType], null: false
    def tags
      Tag.all
    end

    field :comment, CommentType, null: true do
      argument :id, ID, required: true
    end
    def comment(id:)
      Comment.find_by(id: id)
    end
  end
end
