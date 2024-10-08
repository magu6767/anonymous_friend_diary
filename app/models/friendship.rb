class Friendship < ApplicationRecord
  belongs_to :user1, class_name: 'User'
  belongs_to :user2, class_name: 'User'
  
  # friend_requestとfriendshipを独立させるため、関連は持たせないことに
  # has_one :friend_request, dependent: :destroy

  validates :user1_id, uniqueness: { scope: :user2_id }
  validate :not_self

  private

  def not_self
    errors.add(:user2, "can't be equal to user1") if user1 == user2
  end
end