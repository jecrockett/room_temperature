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
      req.params['oldest'] = Sentiment.last.slack_id
    end
    parsed_response = JSON.parse(response.body)
    parsed_response['messages'].to_a
  end


end
