class FriendRequest < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'
  belongs_to :post, class_name: 'Post'

  # friend_requestとfriendshipを独立させるため、関連は持たせないことに
  # has_one :friendship, required: false

  enum status: { pending: 0, accepted: 1, rejected: 2 }

  validates :sender_id, uniqueness: { scope: [:receiver_id, :post_id] }
  validate :not_self
  validate :not_friends
  validate :invalid_post


  def accepted?
    status == 'accepted'
  end

  def rejected?
    status == 'rejected'
  end

  private

  def not_self
    errors.add(:receiver, "can't be equal to sender") if sender == receiver
  end

  def not_friends
    errors.add(:receiver, 'is already added') if sender.friends.include?(receiver)
  end

  def invalid_post
    errors.add(:post, 'is invalid') if post.user_id != receiver.id
  end
end