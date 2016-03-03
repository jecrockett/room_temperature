class DashboardsController < ApplicationController

  def show
    if (params[:channel] && Channel.all.collect(&:name).include?(params[:channel][:name]))
      # show data for that channel
    else
      # default to first channel
    end
  end

end
