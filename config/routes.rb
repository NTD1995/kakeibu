Rails.application.routes.draw do
  # トップページ
  root to: "public/homes#top"
  # アバウトページ
  get "/about", to: "public/homes#about", as: "about"
  # 新規登録画面、ユーザーログイン画面
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  # 投稿
  resources :posts, controller: 'public/posts', only: [:new, :index, :show, :edit, :create]


  # 管理者側

  # 管理者トップページ（投稿一覧）
  get "/admin", to: "admin/homes#top", as: "admin/top"
  # 管理者ログイン画面
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
end
