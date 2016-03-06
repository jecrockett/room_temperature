desc "TODO"
task pull_channels: [:environment] do
  slack = SlackService.new
  Indico.api_key = ENV['INDICO_KEY']
  channels = Channel.all

  channels.each do |channel|
    response = slack.pull_new_channels(channel, ENV['SLACK_TOKEN'])

    if response.empty?
      puts "No new messages in #{channel.name}."
      next
    end

    messages = response.map { |msg_hash| msg_hash["text"] }
    sanitized_messages = MessageSanitizer.sanitize(messages)
    sentiments = Indico.sentiment(sanitized_messages)


    # ensures new database entries are added from most outdated to most recent
    response.reverse!
    sentiments.reverse!

    response.each_with_index do |info, index|
      s = Sentiment.create
      s.user_id = User.find_or_create_by(u_id: info['user']).id
      s.channel_id = channel.id
      s.team_id = channel.team.id
      s.slack_id = info['ts']
      s.timestamp = Time.at(info['ts'].to_i).to_datetime
      s.score = sentiments[index]

      s.save
    end
  end
end
