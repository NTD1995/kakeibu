class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  # モデル間の関連付け
  has_many :posts
  has_one_attached :image

  # バリデーション設定
  validates :name, presence: true
  validates :introduction, presence: true   
end
