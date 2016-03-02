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
      req.params['oldest'] = Sentiment.last.slack_id if Sentiment.last
      # this will need to change so theat the sentiment is scoped by channel
      # should be esy since that's directly available.
      # actually that can be implemented immediately but i'm tooo tired. do it.
    end
    parsed_response = JSON.parse(response.body)
    parsed_response['messages'].to_a
  end


end
