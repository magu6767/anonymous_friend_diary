require "test_helper"

class FriendRequestsCreateTest < ActionDispatch::IntegrationTest
  
    def setup
      @sender = users(:one)
      @post_by_receiver = posts(:post_by_two)
      @post_by_other = posts(:post_by_three)
    end
  
    test "should create friend request with valid information" do
      log_in_as(@sender)
      get post_path(@post_by_receiver)
      assert_difference 'FriendRequest.count', 1 do
        post friend_requests_path, params: { friend_request: { post_id: @post_by_receiver.id } }
      end
      assert_redirected_to post_path(@post_by_receiver)
      assert_not flash.empty?
    end

end
