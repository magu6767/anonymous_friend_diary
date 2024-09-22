require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post_by_one = posts(:orange)
    @user = users(:one)
    @other_user = users(:two)
  end

  test "should get new when logged in " do
    log_in_as(@user)
    get new_post_path
    assert_response :success
  end

  test "should redirect new when not logged in" do
    get new_post_path
    assert_redirected_to login_url
  end

  test "should get index" do
    get posts_path
    assert_response :success
  end

  test "should get show" do
    get post_path(@post_by_one)
    assert_response :success
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Post.count' do
      post posts_path, params: { post: { title: "Lorem ipsum", 
                                content: "Lorem ipsum" } }
    end
    assert_redirected_to login_url
  end

  test "should get edit" do
    log_in_as(@user)
    get edit_post_path(@post_by_one)
    assert_response :success
  end

  test "should redirect edit when not logged in" do
    get edit_post_path(@post_by_one)
    assert_redirected_to login_url
  end

  test "should redirect edit when logged in as wrong user" do
    log_in_as(@other_user)
    get edit_post_path(@post_by_one)
    assert_redirected_to root_url
  end

  test "should redirect update when not logged in" do
    title = "example title"
    content = "example content"
    patch post_path(@post_by_one), params: { post: { title: title, content: content } }
    assert_redirected_to login_url
  end

  test "should redirect delete when not logged in" do
    assert_no_difference 'Post.count' do
      delete post_path(@post_by_one)
    end
    assert_redirected_to login_url
  end

  test "should redirect delete when logged in as wrong user" do
    log_in_as(@other_user)
    assert_no_difference 'Post.count' do
      delete post_path(@post_by_one)
    end
    assert_redirected_to root_url
  end
end
