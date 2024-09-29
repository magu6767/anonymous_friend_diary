class FriendshipsController < ApplicationController
  before_action :logged_in_user, only: [:index, :show, :create, :destroy]

  def index
    @friendships = current_user.friends
  end

  def create
    @friendship = Friendship.new(friendship_params)
    if @friendship.save
      flash[:notice] = "Friendship was successfully created."
      redirect_to friendships_path
    else
      flash[:error] = "Friendship was not created."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @friendship = Friendship.find(params[:id])
    if @friendship.destroy
      flash[:notice] = "Friendship was successfully deleted."
    else
      flash[:error] = "Friendship was not deleted."
    end
    redirect_to friendships_path
  end

  private

    def friendship_params
      params.require(:friendship).permit(:user1_id, :user2_id)
    end
end
