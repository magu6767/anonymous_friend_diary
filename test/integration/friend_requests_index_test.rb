require "test_helper"

class FriendRequestsIndexTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
  end

  test "should get friend requests index" do
    log_in_as(@user)
    sent_friend_requests = @user.sent_friend_requests
    received_friend_requests = @user.received_friend_requests

    get friend_requests_path
    assert_template 'friend_requests/index'

    sent_friend_requests.each do |s_request|
      assert_select 'a[href=?]', post_path(s_request.post), text: s_request.post.title
    end

    received_friend_requests.each do |r_request|
      assert_select 'a[href=?]', user_path(r_request.sender), text: r_request.sender.name
      assert_select 'a[href=?]', post_path(r_request.post), text: r_request.post.title
    end

  end
end
