require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  test "should return empty list of posts" do
    get "/posts"
    assert_equal @response.status, 200
    assert_equal @response.body, {posts: []}.to_json
  end
end
