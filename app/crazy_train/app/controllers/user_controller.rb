class UserController < ApplicationController
  def create
    hashed_password = BCrypt::Password.create(user_params[:password])

    user = User.create(username: user_params[:username], hashed_password: hashed_password)

    access_token = JWT.encode({data: user.id}, CrazyTrain::Application.config.jwt_secret, "HS256")

    render json: {user: user.as_json, access_token: access_token}, status: :created
  end

  def show
    auth_header = request.headers["authorization"]
    if auth_header.nil?
      render json: {}, status: :unauthorized

      return
    end

    access_token = request.headers["authorization"].split(" ")[1]
    if access_token.nil?
      render json: {}, status: :unauthorized

      return
    end

    payload = JWT.decode(access_token, CrazyTrain::Application.config.jwt_secret, true)
    found_user_id = payload[0]["data"]
    if found_user_id.nil?
      render json: {}, status: :unauthorized

      return
    end

    user = User.find_by id: found_user_id
    if user.nil?
      render json: {}, status: :unauthorized

      return
    end

    render json: {user: user.as_json}, status: :ok
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
