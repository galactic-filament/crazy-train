require "test_helper"

class PostTest < ActiveSupport::TestCase
  test "post save happy-path" do
    post = Post.new(body: "Hello, world!")
    post.save!

    assert_not_equal post.id, nil
  end

  test "post flag invalid with missing body" do
    post = Post.new(body: "")
    assert_equal post.valid?, false
  end
end
