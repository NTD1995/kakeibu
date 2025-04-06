class Favorite < ApplicationRecord
  belongs_to :admin, optional: true
  belongs_to :user, optional: true
  belongs_to :post
  has_one :notification, as: :notifiable, dependent: :destroy  

  # 同じuser_idがpost_idごとに一意であること
  validates :user_id, uniqueness: { scope: :post_id }

  # 投稿者に対していいねされたことを通知するため、投稿者に対して通知を作成
  after_create do
    create_notification(user_id: post.user_id)
  end

end
