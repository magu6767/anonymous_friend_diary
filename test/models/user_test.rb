require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(email: "test@example.com", password: "password", name: "testuser")
  end

  test "valid user" do
    assert @user.valid?
  end

  test "invalid without email" do
    @user.email = nil
    refute @user.valid?, 'user is valid without email'
    assert_not_nil @user.errors[:email], 'no validation error for email present'
  end

  test "invalid with duplicate email" do
    duplicate_user = @user.dup
    @user.save
    refute duplicate_user.valid?, 'user is valid with a duplicate email'
  end

  test "invalid with duplicate name" do
    duplicate_user = @user.dup
    duplicate_user.email = "another@example.com"
    @user.save
    refute duplicate_user.valid?, 'user is valid with a duplicate name'
  end

  test "invalid with short password" do
    @user.password = "short"
    refute @user.valid?, 'user is valid with a short password'
  end

  test "has many posts" do
    assert_respond_to @user, :posts
  end

  test "has many sent friend requests" do
    assert_respond_to @user, :sent_friend_requests
  end

  test "has many received friend requests" do
    assert_respond_to @user, :received_friend_requests
  end

  test "has many friends" do
    user1 = User.create(email: "user1@example.com", password: "password", name: "user1")
    user2 = User.create(email: "user2@example.com", password: "password", name: "user2")
    Friendship.create(user1: user1, user2: user2)
    assert_includes user1.friends, user2
    assert_includes user2.friends, user1
  end
end

