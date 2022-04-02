class UserController < ApplicationController
  def create_user
    hashed_password = BCrypt::Password.create(user_params[:password])

    user = User.create(username: user_params[:username], hashed_password: hashed_password)

    access_token = JWT.encode({data: user.id}, Rails.application.credentials[:secret_key_base], "HS256")

    render json: {user: user.as_json, access_token: access_token}, status: :created
  end

  def get_user
    access_token = request.headers["authorization"].split(" ")[1]
    payload = JWT.decode(access_token, Rails.application.credentials[:secret_key_base], true)
    puts payload[0]["data"]

    render plain: "Pong", status: :unauthorized
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
