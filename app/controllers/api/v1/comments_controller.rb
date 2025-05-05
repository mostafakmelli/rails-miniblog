module Api
  module V1
    class CommentsController < ApplicationController
      before_action :set_comment, only: %i[show update destroy]

      def show
        render json: @comment
      end

      def update
        form = CommentForm.new(comment_params.merge(id: @comment.id))
        if form.valid?
          @comment.update!(form.to_h)
          render json: @comment
        else
          render json: { errors: form.errors.to_h }, status: :unprocessable_entity
        end
      end

      def destroy
        @comment.destroy
        head :no_content
      end

      private

      def set_comment
        @comment = Comment.find(params[:id])
      end

      def comment_params
        params.require(:comment).permit(:user_id, :body)
      end
    end
  end
end
