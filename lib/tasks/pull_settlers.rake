desc "TODO"
task pull_settlers: [:environment] do
  slack = SlackService.new
  Indico.api_key = ENV['INDICO_KEY']
  settlers = 'G0LFSMSRH'

  response = slack.pull_new_groups(settlers, ENV['SLACK_TOKEN'])

  if response.empty?
    puts "No new messages in settlers-hardcore."
    next
  end

  messages = response.map { |msg_hash| msg_hash["text"] }
  sentiments = Indico.sentiment(messages)

  # ensures new database entries are added from most outdated to most recent
  response.reverse!
  sentiments.reverse!

  response.each_with_index do |info, index|
    s = Sentiment.create
    s.user_id = User.find_or_create_by(u_id: info['user']).id
    s.channel_id = settlers
    s.team_id = 'T029P2S9M'
    s.slack_id = info['ts']
    s.score = sentiments[index]

    s.save
  end

end
