class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  # モデル間の関連付け
  has_many :posts, dependent: :destroy
  has_one_attached :image

  # バリデーション設定
  validates :name, presence: true
  validates :introduction, presence: true  
  
  # ユーザーが退会していないか確認
  def active?
    self.is_active
  end

  # Userモデルのnameカラムに対して検索
  def self.search_for(content, method)
    if method == 'perfect'
      User.where(name: content)
    elsif method == 'forward'
      User.where('name LIKE ?', content + '%')
    elsif method == 'backward'
      User.where('name LIKE ?', '%' + content)
    else
      User.where('name LIKE ?', '%' + content + '%')
    end
  end  
end
