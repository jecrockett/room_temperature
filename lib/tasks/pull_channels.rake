desc "TODO"
task pull_channels: [:environment] do

  # expire sentiments in database that are more than a week old
  Sentiment.all.each { |s| s.delete if s.slack_id.to_i < 7.days.ago.to_i}


  slack = SlackService.new
  Indico.api_key = ENV['INDICO_KEY']
  channels = Channel.all

  # call to slack to pull new messges for each channel
  channels.each do |channel|
    response = slack.pull_new_channels(channel, ENV['SLACK_TOKEN'])

    # if there are no new messages, skip to the next channel now
    if response.empty?
      puts "No new messages in #{channel.name}."
      next
    end

    # if ther are new ones, grab text and send away for sentiment analysis
    messages = response.map { |msg_hash| msg_hash["text"] }
    sentiments = Indico.sentiment(messages)

    # ensures new database entries are added from most outdated to most recent
    response.reverse!
    sentiments.reverse!

    # create sentiments and save to database
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
