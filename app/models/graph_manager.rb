class GraphManager
  attr_reader :channel, :user, :range

  def initialize(channel, user, range)
    @channel = channel
    @user = user
    @range = range
  end

  def channel_data
    if channel.nil? || channel.empty?
      nil
    elsif user.empty? || user.nil?
      complete_channel_data
    else
      partial_channel_data
    end
  end

  def complete_channel_data
    Rails.cache.fetch("#{range}-channel_#{channel}-complete-#{Sentiment.where(channel_id: channel).last.slack_id}") do
      scoped_sentiments.where(channel_id: channel).pluck(:slack_id, :score)
    end
  end

  def partial_channel_data
    Rails.cache.fetch("#{range}-channel_#{channel}-user_#{user}-partial-#{Sentiment.where(channel_id: channel).last.slack_id}") do
      scoped_sentiments.where(channel_id: channel).where.not(user_id: user).pluck(:slack_id, :score)
    end
  end

  def user_data
    return nil if channel.nil? || channel.empty? || user.nil? || user.empty?
    Rails.cache.fetch("#{range}-user_#{user}-channel_#{channel}-#{Sentiment.where(channel_id: channel).last.slack_id}") do
      scoped_sentiments.where(channel_id: channel, user_id: user).pluck(:slack_id, :score)
    end
  end

  def chart_title
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
    Sentiment.all
  end
end
