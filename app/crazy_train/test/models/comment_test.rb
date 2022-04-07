require "test_helper"

class CommentTest < ActiveSupport::TestCase
  test "save happy-path" do
    user = User.new(username: "user", hashed_password: BCrypt::Password.create("password"))
    user.save!
    assert_not_equal user.id, nil

    post = Post.new(body: "Hello, world!")
    post.save!
    assert_not_equal post.id, nil

    comment = Comment.new(body: "Hello, world!", user: user, post: post)
    comment.save!
    assert_not_equal comment.id, nil
  end
end
