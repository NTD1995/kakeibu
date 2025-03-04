class Item < ApplicationRecord
  has_many :post, dependent: :destroy

  # カラムが空でないこと
  validates :name, presence: true
end
