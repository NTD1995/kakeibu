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
  # マイページ
  get "mypage", to: "public/users#mypage", as: "mypage"
  # ユーザー一覧、詳細、編集、更新、退会
  resources :users, controller: "public/users", only: [:index, :show, :edit, :update, :destroy] do
    # フォロー、フォロワー
    resource :relationships, controller: "public/relationships", only: [:create, :destroy]
      get "followers", to: "public/relationships#followers", as: "followers"
  	  get "followeds", to: "public/relationships#followeds", as: "followeds"
      # いいねした一覧
      get "favorites", to: "public/favorites#index", as: "favorites"    
  end
  # 投稿
  scope module: :public do
    resources :posts do
      # 投稿に対してコメントの投稿、削除
      resources :post_comments, only: [:create, :destroy]
      # いいねをつける、外す
      resource :favorites, only: [:create, :destroy]
    end
  end
  # 検索一覧
  get "search", to: "public/searches#search", as: "search"


  # 管理者側

  # 管理者トップページ（投稿一覧）
  get "/admin", to: "admin/homes#top", as: "admin"
  # 管理者ログイン画面
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    # ユーザー一覧、詳細、編集、更新
    resources :users, only: [:index, :show, :edit, :update]
    # 投稿詳細、編集、更新、削除
    resources :posts, only: [:show, :edit, :update, :destroy]
    # 項目一覧、追加、編集、更新、削除
    resources :items, only: [:index, :create, :edit, :update, :destroy]  
    # 検索一覧 
    get "search", to: "searches#search", as: "search"  
    # 投稿に対してコメント削除
    resources :post_comments, only: [:destroy]
    # いいねされている投稿一覧、いいねをつける、外す
    resources :favorites, only: [:index, :create, :destroy]
  end

end
