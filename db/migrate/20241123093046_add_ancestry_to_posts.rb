class AddAncestryToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :ancestry, :string
    add_index :posts, :ancestry
  end
end
