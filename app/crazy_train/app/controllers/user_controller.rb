class UserController < ApplicationController
  def create_user
    hashed_password = BCrypt::Password.create(user_params[:password])

    user = User.create(username: user_params[:username], hashed_password: hashed_password)

    access_token = JWT.encode user.id, Rails.application.credentials[:secret_key_base], "HS256"

    render json: {user: user.as_json, access_token: access_token}, status: :created
  end

  def get_user
    render plain: "Pong"
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
