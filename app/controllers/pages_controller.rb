class PagesController < ApplicationController
  def home
    @user = User.new
  end

  def confirmation
    @sign_ups = User.where(city: params[:city]).count
  end

  def confirmation_success
  end
end
