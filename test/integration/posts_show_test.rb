require "test_helper"

class PostsShowTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @other = users(:two)
    @post_by_one = posts(:orange)
    @post_by_one_2 = posts(:tau_manifesto)
  end

  test "should display post title and content on post show page" do
    get post_path(@post_by_one)
    assert_response :success
    assert_match @post_by_one.title, response.body
    assert_match @post_by_one.content, response.body
  end

  test "should display appropriate components on post show page" do
    # Test for user's own post
    log_in_as @user
    get post_path(@post_by_one)
    assert_response :success
    assert_select "button", text: "削除", count: 0


    # Test for other user's post
    log_in_as @other
    get post_path(@post_by_one)
    assert_response :success
    assert_select "button", text: "リクエストを送る", count: 0
  end

end
