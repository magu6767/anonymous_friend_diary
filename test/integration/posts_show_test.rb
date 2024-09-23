require "test_helper"

class PostsShowTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @post_by_one = posts(:orange)
  end

  test "should display post title and content on post show page" do
    get post_path(@post_by_one)
    assert_response :success
    assert_match @post_by_one.title, response.body
    assert_match @post_by_one.content, response.body
  end
end
