class SessionsController < ApplicationController

  def create
    access_token = Faraday.get("https://slack.com/api/oauth.access?client_id=#{ENV['SLACK_KEY']}&client_secret=#{ENV['SLACK_SECRET']}&code=#{params[:code]}")
    binding.pry
    # @user = User.find_or_create_from_auth(request.env['omniauth.auth'])
    # if @user
    #   session[:user_id] = @user.id
    #   redirect_to dashboard_path
    # else
    #   redirect_to root_path
    # end
  end

end
