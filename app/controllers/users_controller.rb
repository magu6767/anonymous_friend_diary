class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:index, :show, :edit, :update, :destroy]
  before_action :correct_user,   only: [:show, :edit, :update]
  before_action :admin_user,     only: [:index, :destroy]


  # GET /users
  def index
    @users = User.paginate(page: params[:page])
  end

  # GET /users/1
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render 'new', status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      flash[:success] = 'User was successfully updated.'
      redirect_to @user
    else
      render :edit, status: :unprocessable_entity # 422 Unprocessable Entity
    end
  end

  # DELETE /users/1
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url, status: :see_other
  end

  private

    # ストロングパラメータ
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                    :password_confirmation)
    end


    # ユーザーの設定
    def set_user
      @user = User.find(params[:id])
    end  

end