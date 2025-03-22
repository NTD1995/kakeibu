class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room

  # バリデーション設定
  # DMで送信できるメッセージは140字以内
  validates :content, presence: true, length: { maximum:140 }
end
