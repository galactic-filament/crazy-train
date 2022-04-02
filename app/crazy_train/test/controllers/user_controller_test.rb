require "test_helper"

class UserControllerTest < ActionDispatch::IntegrationTest
  test "should create a user" do
    body = { user: { username: "username", password: "password" } }.to_json

    post "/users", params: body, headers: { 'content-type': "application/json" }
    assert_equal 201, @response.status
  end

  test "should deny when resolving current user without valid token" do
    get "/user", headers: { 'content-type': "application/json" }
    assert_equal 401, @response.status
  end

  test "should return user data with valid access token" do
    body = { user: { username: "username", password: "password" } }.to_json

    post "/users", params: body, headers: { 'content-type': "application/json" }
    assert_equal 201, @response.status
    parsed_response = JSON.parse @response.body

    get "/user",
        headers: { 'content-type': "application/json", authorization: "Bearer #{parsed_response['access_token']}" }
    assert_equal 200, @response.status
  end
end
