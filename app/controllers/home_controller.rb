class HomeController < ApplicationController
  caches_page :show

  def show
    redirect_to dashboard_path if current_user
  end
end
