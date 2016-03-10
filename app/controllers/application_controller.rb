class ApplicationController < ActionController::Base
  include ActionController::Caching::Pages
  self.page_cache_directory = "#{Rails.root.to_s}/public/page_cache"
  protect_from_forgery with: :exception
  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authorize!
    redirect_to root_path unless current_user
  end
end
