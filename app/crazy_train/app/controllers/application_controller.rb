class ApplicationController < ActionController::API
  protected

  @user = nil

  def require_jwt_token
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

      nil
    end

    @user = user
  end
end
