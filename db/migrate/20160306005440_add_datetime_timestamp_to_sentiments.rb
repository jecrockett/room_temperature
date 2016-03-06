class AddDatetimeTimestampToSentiments < ActiveRecord::Migration
  def change
    add_column :sentiments, :timestamp, :datetime
    Sentiment.find_each do |sentiment|
      sentiment.timestamp = Time.at(sentiment.slack_id.to_i).to_datetime
      sentiment.save!
    end
  end
end
