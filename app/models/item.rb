class Item < ApplicationRecord
  has_many :posts, dependent: :destroy

  # カラムが空でないこと
  validates :name, presence: true

  # カラムには整数0または1が保存
  enum category: { income: 0, expense: 1 }
end