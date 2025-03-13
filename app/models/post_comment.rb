class PostComment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  # カラムが空でないこと
  validates :comment, presence: true
end
