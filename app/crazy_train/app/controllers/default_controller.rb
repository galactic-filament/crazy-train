class DefaultController < ApplicationController
  def index
    render plain: "Hello, world!"
  end

  def ping
    render plain: "Pong"
  end

  def reflection
    render json: JSON.parse(request.body.read).to_json
  end
end
