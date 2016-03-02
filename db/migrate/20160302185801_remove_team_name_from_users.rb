class RemoveTeamNameFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :team_name
  end
end
