module ChannelHandler

  def self.parse_channel_params(params)
    params["channel-select"].split.map { |info| info.gsub(/\W+/, '') }
  end

  def self.untracked_channels(user)
    Rails.cache.fetch("#{Time.now.strftime("%b %e, %l:%M")}") do
      slack = SlackService.new
      team_channels = slack.fetch_team_channels(user)
      parse_untracked(team_channels, user).compact
    end
  end

  def self.parse_untracked(channels, user)
    channels.map do |channel|
      next if already_tracking?(channel, user)
      [channel['name'], [channel['name'], channel['id']]]
    end
  end

  def self.already_tracking?(ch, user)
    user.team.channels.pluck(:slack_id).include?(ch['id'])
  end

  def self.build_channel(params, user)
    info = parse_channel_params(params)
    c = Channel.new
    c.name = info.first
    c.slack_id = info.last
    c.team_id = user.team_id
    c
  end
end
