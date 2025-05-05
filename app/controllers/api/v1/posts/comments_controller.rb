module Api
  module V1
    class Posts::CommentsController < ApplicationController
      before_action :set_post


      def index
        render json: @post.comments.order(created_at: :asc)
      end


      def create
        form = CommentForm.new(post_comment_params.merge(commentable_type: "Post", commentable_id: @post.id))
        if form.valid?
          comment = @post.comments.create!(form.to_h)
          render json: comment, status: :created
        else
          render json: { errors: form.errors.to_h }, status: :unprocessable_entity
        end
      end

      private

      def set_post
        @post = Post.find(params[:post_id])
      end

      def post_comment_params
        params.require(:comment).permit(:user_id, :body)
      end
    end
  end
end
