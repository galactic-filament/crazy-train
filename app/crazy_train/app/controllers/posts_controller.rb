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

  def update
    post = Post.find_by params[:id]
    if post.nil?
      raise ActiveRecord::RecordNotFound
    end

    post.update(posts_params)

    render json: {post: post}, status: :ok
  end

  private

  def posts_params
    params.require(:post).permit(:body)
  end
end
