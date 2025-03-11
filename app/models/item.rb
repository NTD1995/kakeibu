class Item < ApplicationRecord
  has_many :posts, dependent: :destroy

  # カラムが空でないこと
  validates :name, presence: true
end
