class FriendRequestsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def create
    @post = Post.find_by(id: params[:friend_request][:post_id])
    sender = current_user
    receiver = User.find_by(id: @post.user_id)

    new_request = FriendRequest.new(sender: sender, 
                                    receiver: receiver, 
                                    post: @post,
                                    status: "pending")

    if new_request.save
      flash[:success] = "Friend request sent"
      redirect_to @post
    else
      flash[:danger] = "Friend request failed"
      redirect_to @post
    end
  end

  def destroy
    @user = FriendRequest.find(params[:id]).friend
    current_user.cancel_friend_request(@user)
    redirect_to @user
  end
end
