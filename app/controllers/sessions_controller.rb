class SessionsController < ApplicationController

  def create
    @user = User.find_or_create_from_auth(request.env['omniauth.auth'])
    if @user
      binding.pry
      session[:user_id] = @user.id
      redirect_to dashboard_path
    else
      redirect_to root_path
    end
  end

end
