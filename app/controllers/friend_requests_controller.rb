class FriendRequestsController < ApplicationController
  before_action :logged_in_user, only: [:index, :create, :destroy]

  def index
    @sent_friend_requests = current_user.sent_friend_requests
    @received_friend_requests = current_user.received_friend_requests
  end
  
  def create
    @post = Post.find_by(id: params[:post_id])
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

  def update
    request = FriendRequest.find(params[:id])
    if request.update(status: params[:status])
      if request.accepted?
        friendship = Friendship.new(user1: request.sender, user2: request.receiver)
        if friendship.save
          flash[:success] = "Friend request accepted"
        end
      elsif request.rejected?
        flash[:success] = "Friend request rejected"
      end
    else
      flash[:danger] = "Friend request update failed"  
    end
    redirect_to friend_requests_path
  end

  def destroy
    FriendRequest.find(params[:id]).destroy
    flash[:success] = "Friend request deleted"
    redirect_to friend_requests_url
  end
end
