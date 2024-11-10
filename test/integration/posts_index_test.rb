require "test_helper"

class PostsIndexTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get posts_path
    Post.paginate(page: 1, per_page: 20).each do |post|
      assert_match post.title, response.body
      assert_match post.content, response.body
    end
  end
end
