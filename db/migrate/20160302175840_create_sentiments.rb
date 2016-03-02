class CreateSentiments < ActiveRecord::Migration
  def change
    create_table :sentiments do |t|
      t.references :user, index: true, foreign_key: true
      t.references :team, index: true, foreign_key: true
      t.references :channel, index: true, foreign_key: true
      t.string :slack_id
      t.decimal :score

      t.timestamps null: false
    end
  end
end
