require 'test_helper'

class UsersShowTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:three)
    @users_friend = users(:four)
    @other = users(:one)
  end

  test 'should get list of my own posts' do
    log_in_as @user
    get user_path(@user)
    assert_response :success
    assert_select 'a[href=?]', post_path(@user.posts.first)
    assert_select 'a[href=?]', edit_user_path(@user)
  end

  test "should get show when access a friend's profile" do
    log_in_as @user
    get user_path(@users_friend)
    assert_response :success
    assert_select 'a[href=?]', post_path(@users_friend.posts.first)
    assert_select 'a[href=?]', edit_user_path(@users_friend), false
  end
end
