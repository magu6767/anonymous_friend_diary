class User < ApplicationRecord
  has_secure_password

  has_many :posts, dependent: :destroy
  has_many :sent_friend_requests, class_name: 'FriendRequest', foreign_key: 'sender_id', dependent: :destroy
  has_many :received_friend_requests, class_name: 'FriendRequest', foreign_key: 'receiver_id', dependent: :destroy
  has_many :friendships1, class_name: 'Friendship', foreign_key: 'user1_id', dependent: :destroy
  has_many :friendships2, class_name: 'Friendship', foreign_key: 'user2_id', dependent: :destroy
  has_many :friends1, through: :friendships1, source: :user2
  has_many :friends2, through: :friendships2, source: :user1

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :username, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }, if: -> { new_record? || changes[:password_digest] }

  def friends
    (friends1 + friends2).uniq
  end

  # 渡された文字列のハッシュ値を返す
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end