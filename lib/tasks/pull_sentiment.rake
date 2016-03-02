

desc "TODO"
task pull_messages: [:environment] do
  # messages = ["There''s a point where a thing is too far gone for ethical compostinf", "maybe the <#C0L0M6TKJ> club can try to compost it", "<@U029PR5TG>: Please do not kill it with fire. That\u2019s a bad idea.", "If it smells like a dead body, do you think they even still want it? I would just toss it"]

  # config = {api_key: ENV['INDICO_KEY']}
  # sentiments = Indico.sentiment(messages, config)

  slack = SlackService.new
  Indico.api_key = ENV['INDICO_KEY']

  response = slack.pull_new_messages("C02B05SDQ", ENV['SLACK_TOKEN'])

  next if response.empty?

  messages = response.map { |msg_hash| msg_hash["text"] }
  sentiments = Indico.sentiment(messages)

  # ensures database entries are added from most outdated to most recent
  response.reverse!

  response.each_with_index do |info, index|
    s = Sentiment.create
    s.user_id = User.find_or_create_by(u_id: info['user']).id
    s.channel_id = "C02B05SDQ"
    s.slack_id = info['ts']
    s.score = sentiments[index]

    s.save
  end

end
