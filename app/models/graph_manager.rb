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
      "Sentiments #{chart_range} in #{channel_name}"
    else
      "Sentiments #{chart_range} in #{channel_name} -- Highlighting: #{user_name}"
    end
  end

  def chart_range
    return "This Week" if range == "week"
    return "Today" if range == "0"
    return "Yesterday" if range == "1"
    "#{range} Days Ago"
  end

  def channel_name
    Channel.find(channel_id).name
  end

  def user_name
    User.find(user_id).nickname
  end

  def scoped_sentiments
    range == "week" ? Sentiment.weekly : Sentiment.daily(range)
  end

  def compile_dataset(channel_data, user_data)
    if user_data.blank?
      channel_data
    else
      channel_data + user_data
    end
  end

  def find_endpoints(ch_data, u_data)
    data = compile_dataset(ch_data, u_data)
    return nil if data.blank?

    min = data.map { |a| a[0] }.min
    max = data.map { |a| a[0] }.max
    convert_to_dates(min.to_i, max.to_i)
  end

  def convert_to_dates(min, max)
    [Time.at(min).to_s[5..-7],
     Time.at(max).to_s[5..-7]]
  end
end
