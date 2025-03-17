class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"

  # 同じフォロー関係を重複して作らないようにする
  validates :follower_id, uniqueness: { scope: :followed_id }
end
