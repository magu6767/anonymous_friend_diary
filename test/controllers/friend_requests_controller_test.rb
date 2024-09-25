require "test_helper"

class FriendRequestsControllerTest < ActionDispatch::IntegrationTest

  test "should redirect create when not logged in" do
    assert_no_difference 'FriendRequest.count' do
      post friend_requests_path
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'FriendRequest.count' do
      delete friend_request_path(friend_requests(:one_request))
    end
    assert_redirected_to login_url
  end

end
