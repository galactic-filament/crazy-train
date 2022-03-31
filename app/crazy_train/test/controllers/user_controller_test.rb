require "test_helper"

class UserControllerTest < ActionDispatch::IntegrationTest
  test "should create a user" do
    body = {user: {username: "username", password: "password"}}.to_json

    post "/users", params: body, headers: {'content-type': "application/json"}
    assert_equal 201, @response.status
  end
end
