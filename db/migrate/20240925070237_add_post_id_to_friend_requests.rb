class AddPostIdToFriendRequests < ActiveRecord::Migration[7.0]
  def change
    add_column :friend_requests, :post_id, :integer, null: false
  end
end
