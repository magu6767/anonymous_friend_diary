class User < ApplicationRecord
  include Hashid::Rails
  attr_accessor :remember_token, :activation_token, :reset_token

  before_save   :downcase_email
  before_create :create_activation_digest

  has_secure_password

  has_many :posts, dependent: :destroy
  has_many :sent_friend_requests, class_name: 'FriendRequest', foreign_key: 'sender_id', dependent: :destroy
  has_many :received_friend_requests, -> { where(status: [:pending, :accepted]) }, class_name: 'FriendRequest', foreign_key: 'receiver_id', dependent: :destroy
  # 送信者（user1）として関与している友達関係のリスト
  has_many :friendships1, class_name: 'Friendship', foreign_key: 'user1_id', dependent: :destroy
  # 受信者（user2）として関与している友達関係のリスト
  has_many :friendships2, class_name: 'Friendship', foreign_key: 'user2_id', dependent: :destroy
  # 送信して友達になったユーザー一覧
  has_many :friends1, through: :friendships1, source: :user2
  # 受信して友達になったユーザー一覧
  has_many :friends2, through: :friendships2, source: :user1

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :name, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }, if: -> { new_record? || changes[:password_digest] }

  def friends
    friends1.includes(:friends1) + friends2.includes(:friends2)
  end

  def search_friendship(friend)
    Friendship.where(user1: self, user2: friend).or(Friendship.where(user1: friend, user2: self)).first
  end

  # 渡された文字列のハッシュ値を返す
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # ランダムなトークンを返す
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # 渡されたトークンがダイジェストと一致したらtrueを返す
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  # アカウントを有効にする
  def activate
    update_attribute(:activated,    true)
    update_attribute(:activated_at, Time.zone.now)
  end

  # 有効化用のメールを送信する
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end
  
  # パスワード再設定の属性を設定する
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  # パスワード再設定のメールを送信する
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  # パスワード再設定の期限が切れている場合はtrueを返す
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  private

    # メールアドレスをすべて小文字にする
    def downcase_email
      self.email = email.downcase
    end

    # 有効化トークンとダイジェストを作成および代入する
    def create_activation_digest
      self.activation_token  = User.new_token
      self.activation_digest = User.digest(activation_token)
    end
end