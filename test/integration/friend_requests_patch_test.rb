require "test_helper"

class FriendRequestsPatchTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @sent_friend_requests = @user.sent_friend_requests
    @received_friend_requests = @user.received_friend_requests
  end

  test "approve friend requests and create friendships" do
    log_in_as(@user)
    get friend_requests_path

    assert_difference '@user.friends.count', 1 do
      patch friend_request_path(@received_friend_requests.first), params: { status: 'accepted' }
    end
    assert_redirected_to friend_requests_path
    assert_not flash.empty?

  end

  test "reject friend requests" do
    log_in_as(@user)
    get friend_requests_path

    assert_difference '@received_friend_requests.count', -1 do
      patch friend_request_path(@received_friend_requests.first), params: { status: 'rejected' }
    end

    assert_redirected_to friend_requests_path
    assert_not flash.empty?

  end

  test "cancel friend requests" do
    log_in_as(@user)
    get friend_requests_path

    assert_difference 'FriendRequest.count', -1 do
      delete friend_request_path(@sent_friend_requests.first)
    end

    assert_redirected_to friend_requests_path
    assert_not flash.empty?

  end
end
