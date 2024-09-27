require "test_helper"

class FriendRequestsDeleteTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @friend_request = friend_requests(:for_delete_user_request)
  end

  test "should delete friend request" do
    log_in_as(@user)
    get friend_requests_path
    assert_difference 'FriendRequest.count', -1 do
      delete friend_request_path(@friend_request)
    end
    assert_redirected_to friend_requests_path
    follow_redirect!
    assert_not flash.empty?
  end
end
