class UserController < ApplicationController
  def create_user
    render json: {access_token: ""}, status: :created
  end

  def get_user
    render plain: "Pong"
  end

  private

  def user_params
    params.require(:user).permit(:body)
  end
end
