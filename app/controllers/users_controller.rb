class UsersController < ApplicationController
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
end