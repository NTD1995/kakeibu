Rails.application.routes.draw do
  # ユーザー側
  # トップページ
  root to: "public/homes#top"

  # 管理者側
  # 管理者トップページ（投稿一覧）
  get "/admin", to: "admin/homes#top", as: "admin/top"
end
