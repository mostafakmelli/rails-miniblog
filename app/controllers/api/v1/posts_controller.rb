# app/controllers/api/v1/posts_controller.rb
module Api
  module V1
    class PostsController < ApplicationController
      before_action :set_post, only: %i[show update destroy]


      def index
        posts = Post.published.order(published_at: :desc)
        render json: posts
      end


      def show
        render json: @post
      end


      def create
        form = PostForm.new(permitted_params)
        if form.valid?
          post = Post.create!(form.to_h.merge(published_at: Time.current))
          NotifySubscribersJob.perform_later(post.id)
          render json: post, status: :created
        else
          render json: { errors: form.errors.to_h }, status: :unprocessable_entity
        end
      end


      def update
        form = PostForm.new(permitted_params.merge(id: @post.id))
        if form.valid?
          @post.update!(form.to_h)
          render json: @post
        else
          render json: { errors: form.errors.to_h }, status: :unprocessable_entity
        end
      end


      def destroy
        @post.destroy
        head :no_content
      end

      private

      def set_post
        @post = Post.find(params[:id])
      end

      def permitted_params
        params.require(:post).permit(:user_id, :title, :content, :category_id, tag_ids: [])
      end
    end
  end
end
