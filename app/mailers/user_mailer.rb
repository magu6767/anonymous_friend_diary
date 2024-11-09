class UserMailer < ApplicationMailer

  def account_activation(user)
    @user = user
    mail to: user.email, subject: "アカウント有効化のお知らせ"
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: "パスワードのリセット"
  end
end
