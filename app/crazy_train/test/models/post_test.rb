require "test_helper"

class PostTest < ActiveSupport::TestCase
  test "post create happy-path" do
    post = Post.new(body: "Hello, world!")
    post.save!

    assert_not_equal post.id, nil
  end
end
