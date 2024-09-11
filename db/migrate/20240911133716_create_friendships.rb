class CreateFriendships < ActiveRecord::Migration[7.0]
  def change
    create_table :friendships do |t|
      t.references :user1, null: false, foreign_key: true
      t.references :user2, null: false, foreign_key: true

      t.timestamps
    end
  end
end
