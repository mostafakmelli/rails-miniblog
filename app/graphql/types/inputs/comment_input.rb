module Types
  module Inputs
    class CommentInput < Types::BaseInputObject
      argument :user_id, ID, required: true
      argument :body, String, required: true
      argument :commentable_type, String, required: true
      argument :commentable_id, ID, required: true
    end
  end
end
