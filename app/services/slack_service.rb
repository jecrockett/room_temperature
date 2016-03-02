class SlackService
  attr_reader :conn

  def initialize
    @conn = Faraday.new(:url => 'https://slack.com') do |faraday|
      faraday.request  :url_encoded
      faraday.adapter  Faraday.default_adapter
    end
  end

  def pull_new_messages(channel, token)
    response = conn.get do |req|
      req.url '/api/channels.history'
      req.params['channel'] = channel
      req.params['token'] = token
    end
  end


end
