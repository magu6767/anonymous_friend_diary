require "test_helper"

class FriendshipTest < ActiveSupport::TestCase
  def setup
    @user1 = User.create(email: "user1@example.com", password: "password", name: "user1")
    @user2 = User.create(email: "user2@example.com", password: "password", name: "user2")
    @friendship = Friendship.new(user1: @user1, user2: @user2)
  end

  test "valid friendship" do
    assert @friendship.valid?
  end

  test "invalid when user1 and user2 are the same" do
    @friendship.user2 = @user1
    refute @friendship.valid?, 'friendship is valid when user1 and user2 are the same'
  end

  test "invalid when friendship already exists" do
    @friendship.save
    duplicate_friendship = Friendship.new(user1: @user1, user2: @user2)
    refute duplicate_friendship.valid?, 'friendship is valid when it already exists'
  end

  test "belongs to user1" do
    assert_respond_to @friendship, :user1
  end

  test "belongs to user2" do
    assert_respond_to @friendship, :user2
  end
end