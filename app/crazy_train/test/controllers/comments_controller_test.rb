require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  test "should return blank comments (user route)" do
    hashed_password = BCrypt::Password.create "password"
    user = User.create(username: "username", hashed_password: hashed_password)
    access_token = JWT.encode({data: user.id}, CrazyTrain::Application.config.jwt_secret, "HS256")

    get "/user/comments",
      headers: {'content-type': "application/json", authorization: "Bearer #{access_token}"}
    assert_equal 200, @response.status
    parsed_response = JSON.parse @response.body
    assert_equal 0, parsed_response["comments"].size
  end

  test "should return blank comments (resources route)" do
    hashed_password = BCrypt::Password.create "password"
    user = User.create(username: "username", hashed_password: hashed_password)
    access_token = JWT.encode({data: user.id}, CrazyTrain::Application.config.jwt_secret, "HS256")

    get "/comments",
      headers: {'content-type': "application/json", authorization: "Bearer #{access_token}"}
    assert_equal 200, @response.status
    parsed_response = JSON.parse @response.body
    assert_equal 0, parsed_response["comments"].size
  end

  test "should return one comment" do
    post = Post.create! body: "Hello, world!"

    hashed_password = BCrypt::Password.create "password"
    user = User.create(username: "username", hashed_password: hashed_password)

    Comment.create! post: post, user: user, body: "Hello, world!"

    access_token = JWT.encode({data: user.id}, CrazyTrain::Application.config.jwt_secret, "HS256")

    get "/comments",
      headers: {'content-type': "application/json", authorization: "Bearer #{access_token}"}
    assert_equal 200, @response.status
    parsed_response = JSON.parse @response.body
    assert_equal 1, parsed_response["comments"].size
  end

  test "should create a comment" do
    post = Post.create! body: "Hello, world!"

    hashed_password = BCrypt::Password.create "password"
    user = User.create(username: "username", hashed_password: hashed_password)

    access_token = JWT.encode({data: user.id}, CrazyTrain::Application.config.jwt_secret, "HS256")
    body = {comment: {body: "Hello, world!", post_id: post.id}}.to_json

    post "/comments",
      headers: {'content-type': "application/json", authorization: "Bearer #{access_token}"}, params: body
    assert_equal 201, @response.status
  end

  test "should show a comment" do
    post = Post.create! body: "Hello, world!"

    hashed_password = BCrypt::Password.create "password"
    user = User.create(username: "username", hashed_password: hashed_password)

    comment = Comment.create! post: post, user: user, body: "Hello, world!"

    access_token = JWT.encode({data: user.id}, CrazyTrain::Application.config.jwt_secret, "HS256")

    get "/comments/#{comment.id}",
      headers: {'content-type': "application/json", authorization: "Bearer #{access_token}"}
    assert_equal 200, @response.status
  end

  test "should update a comment" do
    post = Post.create! body: "Hello, world!"

    hashed_password = BCrypt::Password.create "password"
    user = User.create(username: "username", hashed_password: hashed_password)

    comment = Comment.create! post: post, user: user, body: "Hello, world!"

    access_token = JWT.encode({data: user.id}, CrazyTrain::Application.config.jwt_secret, "HS256")
    body = {comment: {body: "Jello, world!", post_id: post.id}}.to_json

    patch "/comments/#{comment.id}",
      headers: {'content-type': "application/json", authorization: "Bearer #{access_token}"}, params: body
    assert_equal 200, @response.status
  end

  test "should destroy a comment" do
    post = Post.create! body: "Hello, world!"

    hashed_password = BCrypt::Password.create "password"
    user = User.create(username: "username", hashed_password: hashed_password)

    comment = Comment.create! post: post, user: user, body: "Hello, world!"

    access_token = JWT.encode({data: user.id}, CrazyTrain::Application.config.jwt_secret, "HS256")

    delete "/comments/#{comment.id}",
      headers: {'content-type': "application/json", authorization: "Bearer #{access_token}"}
    assert_equal 204, @response.status
  end
end
