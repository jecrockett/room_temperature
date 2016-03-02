class CreateChannels < ActiveRecord::Migration
  def change
    create_table :channels do |t|
      t.string :name
      t.references :team, index: true, foreign_key: true
      t.string :slack_id

      t.timestamps null: false
    end
  end
end
