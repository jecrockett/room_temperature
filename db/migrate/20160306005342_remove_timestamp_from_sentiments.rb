class RemoveTimestampFromSentiments < ActiveRecord::Migration
  def change
    remove_column :sentiments, :timestamp
  end
end
