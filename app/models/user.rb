class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  # モデル間の関連付け
  has_many :posts, dependent: :destroy
  has_one_attached :image
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  # ユーザーがフォローしている他のユーザーとの関連付け
  has_many :active_relationships, class_name: "Relationship", foreign_key: :follower_id, dependent: :destroy
  # ユーザーがフォローされている他のユーザーとの関連付け
  has_many :passive_relationships, class_name: "Relationship", foreign_key: :followed_id, dependent: :destroy
  # フォローしているユーザーを取得
  has_many :followeds, through: :active_relationships, source: :followed
  # フォローされているユーザーを取得
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :entries, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :rooms, through: :entries
  has_many :notifications, dependent: :destroy  

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

   # 指定したユーザーをフォローする
  def follow(user)
    active_relationships.create(followed_id: user.id)
  end
  
  # 指定したユーザーのフォローを解除する
  def unfollow(user)
    active_relationships.find_by(followed_id: user.id).destroy
  end
  
  # 指定したユーザーをフォローしているかどうかを判定
  def following?(user)
    followeds.include?(user)
  end

  # 指定したユーザーにフォローされているかどうかを判定
  def follower_by?(user)
    passive_relationships.find_by(follower_id: user.id).present?
  end

  # 指定したユーザーをフォローしているかどうかをデータベースに都度問い合わせて判定
  def followed_by?(user)
    active_relationships.find_by(followed_id: user.id).present?
  end
end
