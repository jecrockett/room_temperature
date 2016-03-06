class GraphManager
  attr_reader :channel, :user, :range

  def initialize(channel, user, range)
    @channel = channel
    @user = user
    @range = range
  end

  def set_chart_data
    if channel.nil? || channel.empty?
      nil
    else
      scoped_sentiments.where(channel_id: channel).pluck(:slack_id, :score)
    end
  end

  def set_channel_data
    scoped_sentiments.where(channel_id: channel).where.not(user_id: user).pluck(:slack_id, :score)
  end

  def set_user_data
    scoped_sentiments.where(channel_id: channel, user_id: user).pluck(:slack_id, :score)
  end

  def set_chart_title
    if channel.nil? || channel.empty?
      "Please select a channel from the dropdown menu."
    elsif user.empty?
      "#{range} Sentiments in #{channel_name}"
    else
      "#{range} Sentiments in #{channel_name} -- Highlighting: #{user_name}"
    end
  end

  def channel_name
    Channel.find(channel).name
  end

  def user_name
    User.find(user).nickname
  end

  def scoped_sentiments
    return Sentiment.weekly  if range == "Weekly"
    return Sentiment.daily   if range == "Daily"
  end
end
