class Post < ApplicationRecord
  # モデル間の関連付け  
  belongs_to :user
  belongs_to :item
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  # カラムが空でないこと
  validates :created_at, presence: true
  validates :content, presence: true
  # カラムが数値であること
  validates :price, presence: true, numericality: true
  # 収支区分が収入または支出であること
  validates :category, presence: true, inclusion: { in: ["income", "expense"] }

  # カラムには整数0または1が保存
  enum category: { income: 0, expense: 1 }

  # Postモデルのcontentカラムに対して検索
  def self.search_for(content, method)
    if method == 'perfect'
      Post.where(content: content)
    elsif method == 'forward'
      Post.where('content LIKE ?', content + '%')
    elsif method == 'backward'
      Post.where('content LIKE ?', '%' + content)
    else
      Post.where('content LIKE ?', '%' + content + '%')
    end
  end  

  # 指定されたユーザが特定の投稿をいいねしているかどうかを判定
  def favorited_by?(user)
    return false if user.nil?
    favorites.exists?(user_id: user.id)
  end

   # 管理者が特定の投稿をいいねしているかどうかを判定
  def favorited_by_for_admin?(admin)
    return false if admin.nil?
    favorites.exists?(admin_id: admin.id)
  end
 
end
