class PostsController < ApplicationController
  def index
    posts = Post.all

    render json: {posts: posts}
  end

  def show
    post = Post.find_by id: params[:id]
    if post.nil?
      raise ActiveRecord::RecordNotFound
    end

    render json: post
  end

  def destroy
    post = Post.find_by id: params[:id]
    if post.nil?
      raise ActiveRecord::RecordNotFound
    end

    post.destroy!

    render json: {}, status: :no_content
  end

  def update
    post = Post.find_by id: params[:id]
    if post.nil?
      raise ActiveRecord::RecordNotFound
    end

    post.update(posts_params)

    render json: post, status: :ok
  end

  def create
    post = Post.create posts_params

    render json: post, status: :created
  end

  private

  def posts_params
    params.require(:post).permit(:body)
  end
end
