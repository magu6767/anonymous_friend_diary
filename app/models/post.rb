class Post < ApplicationRecord
  belongs_to :user, optional: false

  default_scope -> { order(created_at: :desc) }
  validates :title, presence: true
  validates :content, presence: true, length: { maximum: 20000 }
end