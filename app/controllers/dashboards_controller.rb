class DashboardsController < ApplicationController

  def show
    gm = GraphManager.new(params[:channel], params[:user], params[:range])
    if params[:user].nil? || params[:user].empty?
      @channel_data = gm.set_chart_data
    else
      @channel_data = gm.set_channel_data
      @user_data = gm.set_user_data
    end
    # @channel_data = gm.set_chart_data
    @chart_title = gm.set_chart_title
  end

end
