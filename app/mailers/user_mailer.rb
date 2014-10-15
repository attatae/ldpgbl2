class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def send_confirm_email(user)
    @user  = user
    @email = user.email
    @token = user.confirmation_token
    mail(to: @email, subject: 'Please confirm your email')
  end
end