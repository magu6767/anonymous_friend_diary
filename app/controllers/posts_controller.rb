class PostsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :correct_post,   only: [:edit, :update, :destroy]

  def index
    @posts = Post.paginate(page: params[:page])
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Post created!"
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
      flash[:success] = "Post updated!"
      redirect_to @post
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    flash[:success] = "Post deleted"
    redirect_to posts_url, status: :see_other
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end

  def correct_post
    @post = Post.find(params[:id])
    unless @post.user == current_user
      flash[:alert] = "You are not authorized to edit this post."
      redirect_to root_url
    end
  end
end
