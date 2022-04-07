require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "save happy-path" do
    user = User.new(username: "user", hashed_password: BCrypt::Password.create("password"))
    user.save!

    assert_not_equal user.id, nil
  end
end
