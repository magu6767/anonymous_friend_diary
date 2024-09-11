class FriendRequest < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'

  enum status: { pending: 0, accepted: 1, rejected: 2 }

  validates :sender_id, uniqueness: { scope: :receiver_id }
  validate :not_self
  validate :not_friends
  validate :not_pending

  private

  def not_self
    errors.add(:receiver, "can't be equal to sender") if sender == receiver
  end

  def not_friends
    errors.add(:receiver, 'is already added') if sender.friends.include?(receiver)
  end

  def not_pending
    errors.add(:receiver, 'already requested friendship') if receiver.sent_friend_requests.pending.where(receiver: sender).exists?
  end
end