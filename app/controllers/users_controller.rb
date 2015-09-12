class UsersController < ApplicationController

  def show
    @user = User.find_by(username: user_params) else
    if not @user
      render :file => "#{Rails.root}/public/404.html",  :status => 404
    end
  end

  private

  # Filter parameters
  def user_params
    params.require(:username)
  end

end
