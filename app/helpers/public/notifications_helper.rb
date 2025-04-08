module Public::NotificationsHelper
  def notification_message(notification)
    case notification.notifiable_type
    when "Post"
      user_name = notification.notifiable.user&.name || "ユーザー"  # 投稿者がnilなら"ユーザー"を表示
      "フォローしている#{user_name}さんが#{notification.notifiable.content}を投稿しました"
    when "Favorite"
      favorite = notification.notifiable
      user_name = if favorite.user.nil?
                    "管理者"  # いいねしたユーザーがnilの場合
                  else
                    favorite.user.name || "ユーザー"  # いいねしたユーザーの名前
                  end
      post_content = favorite.post.content
      "#{user_name}さんが「#{post_content}」にいいねしました"
    else
      "新しい通知があります"
    end
  end
 
end
