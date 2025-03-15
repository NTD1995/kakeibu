class Favorite < ApplicationRecord
  belongs_to :admin, optional: true
  belongs_to :user, optional: true
  belongs_to :post

  # 同じuser_idがpost_idごとに一意であること
  validates :user_id, uniqueness: { scope: :post_id }
end
