require 'test_helper'

class FriendRequestTest < ActiveSupport::TestCase
  def setup
    @sender = User.create(email: 'sender@example.com', password: 'password', name: 'sender')
    @receiver = User.create(email: 'receiver@example.com', password: 'password', name: 'receiver')
    @post = @receiver.posts.build(title: 'Test Title', content: 'This is a test post.')
    @friend_request = FriendRequest.new(sender: @sender, receiver: @receiver, post: @post, status: 'pending')
  end

  test 'valid friend request' do
    assert @friend_request.valid?
  end

  test 'invalid when sender and receiver are the same' do
    @friend_request.receiver = @sender
    refute @friend_request.valid?, 'friend request is valid when sender and receiver are the same'
  end

  test 'invalid when request already exists' do
    @friend_request.save
    duplicate_request = FriendRequest.new(sender: @sender, receiver: @receiver, post: @post, status: 'pending')
    refute duplicate_request.valid?, 'friend request is valid when it already exists'
  end

  test 'invalid when users are already friends' do
    Friendship.create(user1: @sender, user2: @receiver)
    refute @friend_request.valid?, 'friend request is valid when users are already friends'
  end

  test 'belongs to sender' do
    assert_respond_to @friend_request, :sender
  end

  test 'belongs to receiver' do
    assert_respond_to @friend_request, :receiver
  end

  test 'belongs to post' do
    assert_respond_to @friend_request, :post
  end
end
