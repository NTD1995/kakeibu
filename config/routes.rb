Rails.application.routes.draw do
  # ユーザー側
  # トップページ
  root to: "public/homes#top"
  # アバウトページ
  get "/about", to: "public/homes#about", as: "about"

  # 管理者側
  # 管理者トップページ（投稿一覧）
  get "/admin", to: "admin/homes#top", as: "admin/top"
end
