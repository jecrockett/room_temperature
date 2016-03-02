class AddTIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :t_id, :string
  end
end
