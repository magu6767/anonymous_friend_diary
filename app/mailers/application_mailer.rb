class ApplicationMailer < ActionMailer::Base
  default from: "account-verification@anonymous-friend-diary.com"
  layout "mailer"
end
