class ApplicationController < ActionController::Base
  include SessionsHelper

  # ログイン済みユーザーかどうか確認
  def logged_in_user
    unless logged_in?
      store_location # アクセスしようとしたURLを保存
      flash[:danger] = "ログインしてください。"
      redirect_to login_url, status: :see_other
    end
  end
end
