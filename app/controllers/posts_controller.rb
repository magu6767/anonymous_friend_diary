class PostsController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :destroy]
  before_action :correct_post,   only: [:edit, :update, :destroy]

  def index
    @posts = Post.paginate(page: params[:page])
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = if logged_in?
              current_user.posts.build
            else
              Post.new
            end
  end

  def create
    @post = if logged_in?
              current_user.posts.build(post_params)
            else
              Post.new(post_params.merge(user: nil))
            end

    if @post.save
      flash[:success] = "投稿が完了しました!"
      redirect_to @post
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
    Rails.logger.debug "@user user: #{@user.inspect}"
  end

  def update
    if @post.update(post_params)
      flash[:success] = "更新が完了しました!"
      redirect_to @post
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    flash[:success] = "投稿が削除されました"
    redirect_to posts_url, status: :see_other
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end

  def correct_post
    @post = Post.find(params[:id])
    unless @post.user == current_user
      flash[:alert] = "この投稿を編集または削除する権限がありません。"
      redirect_to root_url
    end
  end
end
