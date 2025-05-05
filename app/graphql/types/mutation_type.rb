module Types
  class MutationType < Types::BaseObject
    field :create_post, PostType, null: false do
      argument :input, Inputs::PostInput, required: true
    end
    def create_post(input:)
      form = PostForm.new(input.to_h)
      return GraphQL::ExecutionError.new(form.errors.to_h) unless form.valid?
      Post.create!(form.to_h.merge(published_at: Time.current))
    end

    field :update_post, PostType, null: true do
      argument :id, ID, required: true
      argument :input, Inputs::PostInput, required: true
    end
    def update_post(id:, input:)
      post = Post.find(id)
      form = PostForm.new(input.to_h)
      return GraphQL::ExecutionError.new(form.errors.to_h) unless form.valid?
      post.update!(form.to_h)
      post
    end

    field :delete_post, Boolean, null: false do
      argument :id, ID, required: true
    end
    def delete_post(id:)
      Post.find(id).destroy!
      true
    end

    field :create_comment, CommentType, null: false do
      argument :input, Inputs::CommentInput, required: true
    end
    def create_comment(input:)
      form = CommentForm.new(input.to_h)
      return GraphQL::ExecutionError.new(form.errors.to_h) unless form.valid?
      commentable = input.to_h[:commentable_type].constantize.find(input.to_h[:commentable_id])
      commentable.comments.create!(input.to_h)
    end

    # You can add update_comment/delete_comment here following the same pattern
  end
end
