require "test_helper"

class UserControllerTest < ActionDispatch::IntegrationTest
  test "should create a user" do
    body = {user: {username: "username", password: "password"}}.to_json

    post "/users", params: body, headers: {'content-type': "application/json"}
    assert_equal 201, @response.status
  end

  test "should deny when resolving current user without valid token" do
    get "/user", headers: {'content-type': "application/json"}
    assert_equal 401, @response.status
  end

  test "should return user data with valid access token" do
    body = {user: {username: "username", password: "password"}}.to_json

    post "/users", params: body, headers: {'content-type': "application/json"}
    assert_equal 201, @response.status
    parsed_response = JSON.parse @response.body

    get "/user",
      headers: {'content-type': "application/json", authorization: "Bearer #{parsed_response["access_token"]}"}
    assert_equal 200, @response.status
  end

  test "should return unauthorized with invalid token (no user found)" do
    access_token = JWT.encode({data: "-1"}, Rails.application.credentials[:secret_key_base], "HS256")

    get "/user",
      headers: {'content-type': "application/json", authorization: "Bearer #{access_token}"}
    assert_equal 401, @response.status
  end

  test "should return unauthorized with invalid token (auth header does not split)" do
    get "/user",
      headers: {'content-type': "application/json", authorization: "authorization"}
    assert_equal 401, @response.status
  end

  test "should return unauthorized with invalid token (not jwt decodeable)" do
    access_token = JWT.encode("-1", Rails.application.credentials[:secret_key_base], "HS256")

    get "/user",
      headers: {'content-type': "application/json", authorization: "Bearer #{access_token}"}
    assert_equal 401, @response.status
  end
end
