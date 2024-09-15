require "test_helper"

class PostTest < ActiveSupport::TestCase
  def setup
    @user = User.create(email: "test@example.com", password: "password", name: "testuser")
    @post = Post.new(user: @user, title: "Test Title", content: "Test Content")
  end

  test "valid post" do
    assert @post.valid?
  end

  test "invalid without title" do
    @post.title = nil
    refute @post.valid?, 'post is valid without title'
    assert_not_nil @post.errors[:title], 'no validation error for title present'
  end

  test "invalid without content" do
    @post.content = nil
    refute @post.valid?, 'post is valid without content'
    assert_not_nil @post.errors[:content], 'no validation error for content present'
  end

  test "belongs to user" do
    assert_respond_to @post, :user
  end
end
