class ChannelsController < ApplicationController
  before_action :authorize!

  def index
    @tracked_channels = current_user.team.channels
  end

  def new
    @untracked_channels = ChannelHandler.untracked_channels(current_user)
  end

  def create
    channel = ChannelHandler.build_channel(params, current_user)
    if channel.save
      flash[:notice] = "We'll start gathering data for #{channel.name}."
      flash[:warning] = "Please Note: You will not see data for #{channel.name} appear right away."
      redirect_to channels_path
    else
      flash[:error] = "Something went wrong. Try your selection again."
      @untracked_channels = ChannelHandler.untracked_channels(current_user)
      render :new
    end
  end

  def destroy
    channel = Channel.find(params[:id])
    flash[:notice] = "You've deleted #{channel.name} and all of its sentiments."
    channel.destroy
    redirect_to channels_path
  end
end
