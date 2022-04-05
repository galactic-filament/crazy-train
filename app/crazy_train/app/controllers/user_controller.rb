class UserController < ApplicationController
  before_action :require_jwt_token, only: [:show]

  def create
    hashed_password = BCrypt::Password.create(user_params[:password])

    user = User.create(username: user_params[:username], hashed_password: hashed_password)

    access_token = JWT.encode({data: user.id}, CrazyTrain::Application.config.jwt_secret, "HS256")

    render json: {user: user.as_json, access_token: access_token}, status: :created
  end

  def show
    if @user.nil?
      render json: {}, status: :unauthorized

      return
    end

    render json: {user: @user.as_json}, status: :found
  end

  def admin
    render json: {}, status: :unauthorized
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
