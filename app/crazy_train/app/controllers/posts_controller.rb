class PostsController < ApplicationController
  def index
    posts = Post.all

    render json: {posts: posts}
  end

  def show
    post = Post.find_by params[:id]
    if post.nil?
      raise ActiveRecord::RecordNotFound
    end

    render json: {post: post}
  end

  def destroy
    post = Post.find_by params[:id]
    if post.nil?
      raise ActiveRecord::RecordNotFound
    end

    post.destroy!

    render json: {post: post}, status: :no_content
  end
end
