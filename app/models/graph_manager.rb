class GraphManager

  def set_graph_data(channel, user, range)
    if channel.nil? || channel.empty?
      nil
    elsif user.empty?
      sentiments_scoped(range).where(channel_id: channel).pluck(:slack_id, :score)
    else
      sentiments_scoped(range).where(channel_id: channel, user_id: user).pluck(:slack_id, :score)
    end
  end

  def sentiments_scoped(range)
    return Sentiment.weekly  if range == "Weekly"
    return Sentiment.daily   if range == "Daily"
  end
end
