class Post < ApplicationRecord
  # モデル間の関連付け  
  belongs_to :user
  belongs_to :item
  has_many :post_comments, dependent: :destroy

  # カラムが空でないこと
  validates :created_at, presence: true
  validates :content, presence: true
  # カラムが数値であること
  validates :price, presence: true, numericality: true
  # 収支区分が収入または支出であること
  validates :category, presence: true, inclusion: { in: ["income", "expense"] }

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
end
