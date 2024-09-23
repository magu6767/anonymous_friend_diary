require "test_helper"

class PostsCreateTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
  end

  test "should create a new post" do
    log_in_as(@user)
    assert_difference "Post.count", 1 do
      post posts_path, params: { post: { title: "title",
                                         content: "content" } }
    end
    follow_redirect!
    assert_template "posts/show"
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "should not create a new post with invalid information" do
    log_in_as(@user)
    assert_no_difference "Post.count" do
      post posts_path, params: { post: { title: "",
                                         content: "" } }
    end
    assert_template "posts/new"
  end
end
