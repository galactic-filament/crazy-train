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
    assert_equal post.id, parsed_response["id"]
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

  test "should update for existing post" do
    post = Post.new(body: "Hello, world!")
    post.save!

    next_body = "Jello, world!"

    body = {post: {body: next_body}}.to_json

    patch "/posts/#{post.id}", params: body, headers: {'content-type': "application/json"}
    assert_equal 200, @response.status

    parsed_response = JSON.parse @response.body
    post = Post.find_by parsed_response["post"]["id"].to_s
    assert_equal next_body, post.body
  end

  test "should throw not-found for updating non-exist post" do
    err = nil
    begin
      body = {post: {body: "Jello, world!"}}.to_json
      patch "/posts/0", params: body, headers: {'content-type': "application/json"}
    rescue ActiveRecord::RecordNotFound => e
      err = e
    end

    assert_not_equal err, nil
  end

  test "should throw on updating disallowed field" do
    err = nil
    begin
      post = Post.new(body: "Hello, world!")
      post.save!

      body = {err: "err"}.to_json
      patch "/posts/#{post.id}", params: body, headers: {'content-type': "application/json"}
    rescue ActionController::ParameterMissing => e
      err = e
    end

    assert_not_equal err, nil
  end

  test "should create a post" do
    next_body = "Hello, world!"
    body = {post: {body: next_body}}.to_json

    post "/posts", params: body, headers: {'content-type': "application/json"}
    assert_equal 201, @response.status

    parsed_response = JSON.parse @response.body
    post = Post.find_by parsed_response["id"].to_s
    assert_equal next_body, post.body
  end

  test "should throw on creating disallowed field" do
    err = nil
    begin
      body = {err: "err"}.to_json
      post "/posts", params: body, headers: {'content-type': "application/json"}
    rescue ActionController::ParameterMissing => e
      err = e
    end

    assert_not_equal err, nil
  end
end
