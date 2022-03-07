require "test_helper"

class DefaultControllerTest < ActionDispatch::IntegrationTest
  test "should get boot route" do
    get "/"
    assert_equal @response.status, 200
    assert_equal @response.body, "Hello, world!"
  end

  test "should get ping route" do
    get "/ping"
    assert_equal @response.status, 200
    assert_equal @response.body, "Pong"
  end

  test "should handle reflection correctly" do
    body = {greeting: "Hello, world!"}.to_json

    post "/reflection", params: body, headers: {'content-type': "application/json"}
    assert_equal @response.status, 200
    assert_equal @response.body, body
  end
end
