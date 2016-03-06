class DashboardsController < ApplicationController

  def show
    
    gm = GraphManager.new
    @graph_data = gm.set_graph_data(params[:channel], params[:user], params[:range])
  end

end
