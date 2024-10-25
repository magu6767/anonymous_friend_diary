class FriendshipsController < ApplicationController
  before_action :logged_in_user, only: [:index, :show, :create, :destroy]

  def index
    @friends = current_user.friends
  end

  def create
    @friendship = Friendship.new(friendship_params)
    if @friendship.save
      flash[:notice] = "フレンドが作成されました！"
      redirect_to friendships_path
    else
      flash[:error] = "フレンドの作成に失敗しました。"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @friendship = Friendship.find(params[:id])
    if @friendship.destroy
      flash[:notice] = "フレンドが正常に削除されました。"
    else
      flash[:error] = "フレンドの削除に失敗しました。"
    end
    redirect_to friendships_path
  end

  private

    def friendship_params
      params.require(:friendship).permit(:user1_id, :user2_id)
    end
end
