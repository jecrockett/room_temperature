class DashboardsController < ApplicationController
  before_action :authorize!

  def show
    gm = GraphManager.new(params[:channel], params[:user], params[:range])
    @channel_data = gm.channel_data
    @user_data = gm.user_data
    @chart_title = gm.chart_title
    @x_axis_labels = gm.find_endpoints(@channel_data, @user_data)
  end
end
