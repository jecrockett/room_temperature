class ChannelsController < ApplicationController

  def index
    @tracked_channels = Channel.all
  end

  def new
    @untracked_channels = untracked_channels
  end

  private

    def untracked_channels
      slack = SlackService.new
      team_channels = slack.fetch_team_channels(current_user)
      parse_untracked(team_channels).compact
    end

    def parse_untracked(channels)
      channels.map do |channel|
        next if already_tracking?(channel)
        [channel['name'], channel['id']]
      end
    end

    def already_tracking?(ch)
      Channel.all.pluck(:slack_id).include?(ch['id'])
    end

end
