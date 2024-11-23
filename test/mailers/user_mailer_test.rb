require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test 'account_activation' do
    user = users(:one)
    user.activation_token = User.new_token
    mail = UserMailer.account_activation(user)
    assert_equal 'アカウント有効化のお知らせ', mail.subject
    assert_equal [user.email], mail.to
    assert_equal ['account-verification@anonymous-friend-diary.com'], mail.from
  end

  test 'password_reset' do
    user = users(:one)
    user.reset_token = User.new_token
    mail = UserMailer.password_reset(user)
    assert_equal 'パスワードのリセット', mail.subject
    assert_equal [user.email], mail.to
    assert_equal ['account-verification@anonymous-friend-diary.com'], mail.from
  end
end
