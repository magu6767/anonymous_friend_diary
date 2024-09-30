require 'test_helper'

class FriendshipsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @for_delete_user_1 = users(:for_delete_user_1)
    @for_delete_user_2 = users(:for_delete_user_2)
    @for_delete_user_friendship = friendships(:for_delete_user_friendship)
    @for_create_user_1 = users(:one)
    @for_create_user_2 = users(:two)
  end

  test "should get index" do
    log_in_as @for_delete_user_1 
    get friendships_url
    assert_response :success
    assert_not_nil assigns(:friends)
    assert_equal @for_delete_user_1.friends, assigns(:friends)
  end

  test "should create friendship" do
    log_in_as @for_create_user_1
    assert_difference('Friendship.count', 1) do
      post friendships_url, params: { friendship: { user1_id:@for_create_user_1.id , user2_id:@for_create_user_2.id  } }
    end

    assert_redirected_to friendships_url
    assert_not flash.empty?
  end

  test "should destroy friendship" do
    log_in_as @for_delete_user_1
    assert_difference('Friendship.count', -1) do
      delete friendship_url(@for_delete_user_friendship)
    end

    assert_redirected_to friendships_url
    assert_not flash.empty?
  end
end