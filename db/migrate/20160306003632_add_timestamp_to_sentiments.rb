class AddTimestampToSentiments < ActiveRecord::Migration
  def change
    add_column :sentiments, :timestamp, :integer
    Sentiment.find_each do |sentiment|
      sentiment.timestamp = sentiment.slack_id.to_i
      sentiment.save!
    end
  end
end
