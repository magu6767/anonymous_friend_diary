class ChangeNameColumnInUsers < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :name, :name
  end
end
