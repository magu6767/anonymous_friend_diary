require "test_helper"

class FriendRequestsCreateTest < ActionDispatch::IntegrationTest
  
    def setup
      @sender = users(:one)
      @post_by_receiver = posts(:post_by_two)
      @post_by_receiver_2 = posts(:post_by_two_2)
    end
  
    test "should create friend request with valid information" do
      log_in_as(@sender)
      get post_path(@post_by_receiver)
      assert_difference 'FriendRequest.count', 1 do
        post friend_requests_path, params:  { post_id: @post_by_receiver.id } 
      end
      assert_redirected_to post_path(@post_by_receiver)
      follow_redirect!
      assert_not flash.empty?
      assert_match  "リクエスト済み", response.body

      get post_path(@post_by_receiver_2)
      assert_match  "リクエストを送る", response.body
    end

end
