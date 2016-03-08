class ChannelsController < ApplicationController

  def index
    @tracked_channels = current_user.team.channels
  end

  def new
    @untracked_channels = untracked_channels
  end

  def create
    channel_info = parse_channel_params
    channel = build_channel(channel_info)
    if channel.save
      flash[:notice] = "We'll start gathering data for #{channel.name}. Note: You will not see data for #{channel.name} appear right away."
      redirect_to channels_path
    else
      flash[:error] = "Something went wrong. Try your selection again."
      @untracked_channels = untracked_channels
      render :new
    end
  end

  def destroy
    channel = Channel.find(params[:id])
    flash[:notice] = "You've deleted #{channel.name} and all of its sentiments."
    channel.delete
    redirect_to channels_path
  end

  private

    def parse_channel_params
      params[:info].split.map { |info| info.gsub(/\W+/, '') }
    end

    def untracked_channels
      slack = SlackService.new
      team_channels = slack.fetch_team_channels(current_user)
      parse_untracked(team_channels).compact
    end

    def parse_untracked(channels)
      channels.map do |channel|
        next if already_tracking?(channel)
        [channel['name'], [channel['name'], channel['id']]]
      end
    end

    def already_tracking?(ch)
      current_user.team.channels.pluck(:slack_id).include?(ch['id'])
    end

    def build_channel(info)
      c = Channel.new
      c.name = info.first
      c.slack_id = info.last
      c.team_id = current_user.team_id
      c
    end

end
