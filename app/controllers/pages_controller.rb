class PagesController < ApplicationController
  def home
    @user = User.new
  end

  def confirmation
    @ref = params[:ref]
    @sign_ups = User.where(city: params[:city]).where.not(confirmed_at: nil).count
  end

  def confirmation_success
  end
end
