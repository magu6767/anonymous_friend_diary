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
      flash[:success] = "リクエストを送信しました！"
      redirect_to @post
    else
      flash[:danger] = "リクエストの送信に失敗しました"
      redirect_to @post
    end
  end

  def update
    request = FriendRequest.find(params[:id])
    if request.update(status: params[:status])
      if request.accepted?
        friendship = Friendship.new(user1: request.sender, user2: request.receiver)
        if friendship.save
          flash[:success] = "リクエストを承認しました。"
        end
      elsif request.rejected?
        flash[:success] = "リクエストを拒否しました。"
      end
    else
      flash[:danger] = "リクエストの更新に失敗しました。"
    end
    redirect_to friend_requests_path
  end

  def destroy
    FriendRequest.find(params[:id]).destroy
    flash[:success] = "リクエストを削除しました。"
    redirect_to friend_requests_url
  end
end
