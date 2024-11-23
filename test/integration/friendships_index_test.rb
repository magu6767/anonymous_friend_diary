require 'test_helper'

class FriendshipsIndexTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:three)
    @users_friend = users(:four)
  end

  test 'should get index with friend`s path' do
    log_in_as @user
    get friendships_path
    assert_response :success
    assert_select 'a[href=?]', user_path(@users_friend)
  end
end
