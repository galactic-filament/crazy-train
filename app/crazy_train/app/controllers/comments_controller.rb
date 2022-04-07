class CommentsController < ApplicationController
  before_action :require_jwt_token

  def index
    if @user.nil?
      render json: {}, status: :unauthorized

      return
    end

    render json: {comments: @user.comments}
  end

  def show
    if @user.nil?
      render json: {}, status: :unauthorized

      return
    end

    comment = Comment.find_by id: params[:id], user: @user
    raise ActiveRecord::RecordNotFound if comment.nil?

    render json: comment
  end

  def destroy
    if @user.nil?
      render json: {}, status: :unauthorized

      return
    end

    comment = Comment.find_by id: params[:id], user: @user
    raise ActiveRecord::RecordNotFound if comment.nil?

    comment.destroy!

    render json: {}, status: :no_content
  end

  def update
    if @user.nil?
      render json: {}, status: :unauthorized

      return
    end

    comment = Comment.find_by id: params[:id], user: @user
    raise ActiveRecord::RecordNotFound if comment.nil?

    comment.update(comments_params)

    render json: comment, status: :ok
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
