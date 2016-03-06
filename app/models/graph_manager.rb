class GraphManager

  def set_graph_data(channel, user, range)
    if channel.nil? || channel.empty?
      nil
    elsif user.empty?
      if range == 'Weekly'
        Sentiment.weekly.where(channel_id: channel).pluck(:slack_id, :score)
      elsif range == 'Daily'
        Sentiment.daily.where(channel_id: channel).pluck(:slack_id, :score)
      end
    else
      if range == 'Weekly'
        Sentiment.weekly.where(channel_id: channel, user_id: user).pluck(:slack_id, :score)
      elsif range == 'Daily'
        Sentiment.daily.where(channel_id: channel, user_id: user).pluck(:slack_id, :score)
      end
    end
  end
end
