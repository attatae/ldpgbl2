class RegistrationsController < Devise::RegistrationsController
  def create
    @user = User.new user_params
    if @user.save
      UserMailer.send_confirm_email(@user).deliver
      subscribe_to_mailchimp(@user.email)
      count_referrals
      redirect_to URI.encode("/confirm_your_email?city=#{@user.city}&ref=#{@user.id}"), notice: "Success"
    else
      redirect_to '/', notice: "Error: #{@user.errors.full_messages}"
    end
  end

  private

  def count_referrals
    if params[:ref]
      user = User.find(params[:ref])
      user.referrals = user.referrals ? user.referrals + 1 : 1
      user.save
    end
  end

  def subscribe_to_mailchimp(email)
    list_id = "42868ea987"
    gb = Gibbon::API.new
    result = gb.lists.subscribe({
      :id => list_id,
      :email => {:email => email}
    })
  end

  def user_params
    if Rails.env.test? || Rails.env.development?
      @location ||= Geocoder.search("50.78.167.161").first
    else
      @location ||= request.location
    end
    city = @location.city
    params.require(:user).permit(:email, :city).merge(password: Devise.friendly_token.first(8),
                                                      ip_detected_location: city,
                                                      browser: browser.name )
  end
end