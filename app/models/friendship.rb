class Friendship < ApplicationRecord
  belongs_to :user1, class_name: 'User'
  belongs_to :user2, class_name: 'User'

  validates :user1_id, uniqueness: { scope: :user2_id }
  validate :not_self

  private

  def not_self
    errors.add(:user2, "can't be equal to user1") if user1 == user2
  end
end