class PagesController < ApplicationController
  def home
    @user = User.new
  end

  def confirmation
  end

  def confirmation_success
  end
end
