class Post < ApplicationRecord
  belongs_to :user
  belongs_to :item

  # カラムが空でないこと
  validates :content, presence: true
  # カラムが数値であり、0以上の値であること
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
