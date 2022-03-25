require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  test "should return empty list of posts" do
    get "/posts"
    assert_equal 200, @response.status

    parsed_response = JSON.parse @response.body
    assert_equal 0, parsed_response["posts"].size
  end

  test "should return correct list of posts" do
    post = Post.new(body: "Hello, world")
    post.save!

    get "/posts"
    assert_equal 200, @response.status

    parsed_response = JSON.parse @response.body
    assert_equal 1, parsed_response["posts"].size
  end

  test "should return not found for fetching non-exist post" do
    err = nil
    begin
      get "/posts/0"
    rescue ActiveRecord::RecordNotFound => e
      err = e
    end

    assert_not_equal nil, err
  end

  test "should return ok for fetching existing post" do
    post = Post.new(body: "Hello, world!")
    post.save!

    get "/posts/#{post.id}"
    assert_equal 200, @response.status

    parsed_response = JSON.parse @response.body
    assert_equal post.id, parsed_response["post"]["id"]
  end

  test "should return not found for deleting non-exist post" do
    err = nil
    begin
      delete "/posts/0"
    rescue ActiveRecord::RecordNotFound => e
      err = e
    end

    assert_not_equal err, nil
  end

  test "should return no_content for deleting existing post" do
    post = Post.new(body: "Hello, world!")
    post.save!

    delete "/posts/#{post.id}"
    assert_equal 204, @response.status
  end
end
