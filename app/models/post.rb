class Post < ApplicationRecord
  belongs_to :user, optional: false
  has_many :request, class_name: 'FriendRequest', foreign_key: 'post_id', dependent: :destroy

  default_scope -> { order(created_at: :desc) }
  validates :title, presence: true
  validates :content, presence: true, length: { maximum: 20000 }
end