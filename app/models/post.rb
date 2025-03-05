class Post < ApplicationRecord
  # モデル間の関連付け  
  belongs_to :user
  belongs_to :item

  # カラムが空でないこと
  validates :created_at, presence: true
  validates :content, presence: true
  # カラムが数値であること
  validates :price, presence: true, numericality: true
  # 収支区分が収入または支出であること
  validates :category, presence: true, inclusion: { in: ["income", "expense"] }
end
