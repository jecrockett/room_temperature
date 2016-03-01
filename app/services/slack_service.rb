class SlackService
  attr_reader :slack

  def initialize
    @slack = Faraday.new(:url => 'http://slack.com/api') do |faraday|
      faraday.request  :url_encoded
      faraday.adapter  Faraday.default_adapter
  end

  def pull_new_messages(channel, token)
    response = slack.get do |req|
      req.url '/channels.history'
      req.params['channel'] = channel
      req.params['token'] = token
  end


end
