class CreateSentiments < ActiveRecord::Migration
  def change
    create_table :sentiments do |t|
      t.references :user, index: true, foreign_key: true
      t.string :channel_id
      t.string :slack_id
      t.decimal :score

      t.timestamps null: false
    end
  end
end
