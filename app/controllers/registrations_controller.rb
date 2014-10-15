class RegistrationsController < Devise::RegistrationsController
  def create
    @user = User.new user_params
    if @user.save
      UserMailer.send_confirm_email(@user).deliver
      redirect_to '/confirm_your_email', notice: "Success"
    else
      redirect_to '/', notice: "Error: #{@user.errors.full_messages}"
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :city).merge(password: Devise.friendly_token.first(8))
  end
end