require "test_helper"

class PostTest < ActiveSupport::TestCase
  def setup
    @user = User.create(email: "test@example.com", password: "password", name: "testuser")
    @post = @user.posts.build(title: "Test Post", content: "This is a test post.")
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

  test "should not save post without user" do
    post = Post.new(content: "Test content")
    assert_not post.save, "Saved the post without a user"
  end

  test "content should be at most 10000 characters" do
    @post.content = "a" * 20001
    refute @post.valid?, 'post is valid with content longer than 20000 characters'
  end

  test "order should be most recent first" do
    assert_equal posts(:most_recent), Post.first
  end

  test "should save comment with no title" do
    @post.save
    comment = @post.children.build(title: nil, content: "This is a test comment.", user: @user)
    assert comment.save, "failed to save the comment with no title"
  end

end
