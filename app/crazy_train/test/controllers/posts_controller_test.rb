require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  test "should return empty list of posts" do
    get "/posts"
    assert_equal @response.status, 200

    parsed_response = JSON.parse @response.body
    assert_equal parsed_response["posts"].size, 0
  end

  test "should return correct list of posts" do
    post = Post.new(body: "Hello, world")
    post.save!

    get "/posts"
    assert_equal @response.status, 200

    parsed_response = JSON.parse @response.body
    assert_equal parsed_response["posts"].size, 1
  end

  test "should return not found for non-exist post" do
    err = nil
    begin
      get "/posts/0"
    rescue ActiveRecord::RecordNotFound => e
      err = e
    end

    assert_not_equal err, nil
  end

  test "should existing post" do
    post = Post.new(body: "Hello, world!")
    post.save!

    get "/posts/#{post.id}"
    assert_equal @response.status, 200

    parsed_response = JSON.parse @response.body
    assert_equal parsed_response["post"]["id"], post.id
  end
end
