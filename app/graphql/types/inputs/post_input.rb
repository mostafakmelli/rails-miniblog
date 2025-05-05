module Types
  module Inputs
    class PostInput < Types::BaseInputObject
      argument :user_id, ID, required: true
      argument :title, String, required: true
      argument :content, String, required: true
      argument :category_id, ID, required: true
      argument :tag_ids, [ID], required: false
    end
  end
end
