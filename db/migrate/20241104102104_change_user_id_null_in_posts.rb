class ChangeUserIdNullInPosts < ActiveRecord::Migration[7.0]
  def change
    change_column_null :posts, :user_id, true
  end
end
