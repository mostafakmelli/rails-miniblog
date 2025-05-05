module Types
  class CommentType < BaseObject
    field :id, ID, null: false
    field :body, String, null: false



    field :commentable, Types::BaseObject, null: true do
      argument :type, String, required: false
    end

    def commentable
      object.commentable
    end
  end
end
