class GraphManager
  attr_reader :channel_id, :user_id, :range

  def initialize(channel_id, user_id, range)
    @channel_id = channel_id
    @user_id = user_id
    @range = range
  end

  def channel_data
    return nil if channel_id.blank?
    user_id.blank? ? complete_channel_data : partial_channel_data
  end

  def complete_channel_data
    Rails.cache.fetch("#{range}-channel_#{channel_id}-complete-#{Sentiment.where(channel_id: channel_id).last.slack_id}") do
      scoped_sentiments.where(channel_id: channel_id).pluck(:slack_id, :score)
    end
  end

  def partial_channel_data
    Rails.cache.fetch("#{range}-channel_#{channel_id}-user_#{user_id}-partial-#{Sentiment.where(channel_id: channel_id).last.slack_id}") do
      scoped_sentiments.where(channel_id: channel_id).where.not(user_id: user_id).pluck(:slack_id, :score)
    end
  end

  def user_data
    return nil if channel_id.blank? || user_id.blank?
    Rails.cache.fetch("#{range}-user_#{user_id}-channel_#{channel_id}-#{Sentiment.where(channel_id: channel_id).last.slack_id}") do
      scoped_sentiments.where(channel_id: channel_id, user_id: user_id).pluck(:slack_id, :score)
    end
  end

  def chart_title
    if channel_id.blank?
      "Please select a channel from the dropdown menu."
    elsif user_id.empty?
      "#{range} Sentiments in #{channel_name}"
    else
      "#{range} Sentiments in #{channel_name} -- Highlighting: #{user_name}"
    end
  end

  def channel_name
    Channel.find(channel_id).name
  end

  def user_name
    User.find(user_id).nickname
  end

  def scoped_sentiments
    return Sentiment.weekly  if range == "Weekly"
    return Sentiment.daily   if range == "Daily"
    Sentiment.all
  end
end
