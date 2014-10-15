class UsersController < ApplicationController
  before_filter :authenticate, only: [:registrations]
  def confirm
    @user = User.find(params[:id])
    if @user.confirm (params[:token])
      redirect_to '/success', notice: "Success"
    else
      redirect_to '/success', notice: "Invalid!"
    end
  end

  def registrations
    @users = User.page(params[:page]).per(20)
  end


  def authenticate
    authenticate_or_request_with_http_basic('Administration') do |username, password|
      username == 'admin' && password == 'admin'
    end
  end
end