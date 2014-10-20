class RegistrationsController < Devise::RegistrationsController
  def create
    @user = User.new user_params
    if @user.save
      UserMailer.send_confirm_email(@user).deliver
      subscribe_to_mailchimp(@user.email)
      redirect_to URI.encode("/confirm_your_email?city=#{@user.city}"), notice: "Success"
    else
      redirect_to '/', notice: "Error: #{@user.errors.full_messages}"
    end
  end

  private

  def subscribe_to_mailchimp(email)
    list_id = "42868ea987"
    gb = Gibbon::API.new
    result = gb.lists.subscribe({
      :id => list_id,
      :email => {:email => email}
    })
  end

  def user_params
    params.require(:user).permit(:email, :city).merge(password: Devise.friendly_token.first(8))
  end
end