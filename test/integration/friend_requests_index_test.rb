require "test_helper"

class FriendRequestsIndexTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @sent_friend_requests = @user.sent_friend_requests
    @received_friend_requests = @user.received_friend_requests
  end

  test "should get friend requests index" do
    log_in_as(@user)

    get friend_requests_path
    assert_template 'friend_requests/index'

    @sent_friend_requests.each do |s_request|
      assert_select 'a[href=?]', post_path(s_request.post), text: s_request.post.title
    end

    @received_friend_requests.each do |r_request|
      if r_request.status == ('pending' || 'accepted')
        assert_select 'a[href=?]', post_path(r_request.post), text: r_request.post.title
      end
    end

  end

  test "should redirect friend requests index when not logged in" do
    get friend_requests_path
    assert_redirected_to login_url
  end
end
