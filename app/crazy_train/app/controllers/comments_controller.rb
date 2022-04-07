class CommentsController < ApplicationController
  before_action :require_jwt_token

  def index
    posts = Post.all

    render json: {posts: posts}
  end

  def show
    post = Post.find_by params[:id]
    if post.nil?
      raise ActiveRecord::RecordNotFound
    end

    render json: post
  end

  def destroy
    post = Post.find_by params[:id]
    if post.nil?
      raise ActiveRecord::RecordNotFound
    end

    post.destroy!

    render json: {}, status: :no_content
  end

  def update
    post = Post.find_by params[:id]
    if post.nil?
      raise ActiveRecord::RecordNotFound
    end

    post.update(posts_params)

    render json: post, status: :ok
  end

  def create
    if @user.nil?
      render json: {}, status: :unauthorized

      return
    end

    comment = Comment.create comments_params
    comment.user = @user
    comment.save!

    render json: comment, status: :created
  end

  private

  def comments_params
    params.require(:comment).permit(:body, :post_id)
  end
end
