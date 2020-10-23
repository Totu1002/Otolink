class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :recruits

  has_many :users_prefectures
  has_many :prefectures, through: :users_prefectures

  has_many :users_parts
  has_many :parts, through: :users_parts

  has_many :users_genres
  has_many :genres, through: :users_genres

  has_many :entries, dependent: :destroy
  has_many :messages, dependent: :destroy

  attachment :profile_image, destroy: false

  enum gender: {
    指定なし: 0,
    男性: 1,
    女性: 2
  }

  validates :name, presence: true, length: {maximum: 100}
  validates :introduction, length: {maximum: 500}
  validates :gender, presence: true
  validates :age, presence: true
  #多対多テーブルの項目も必須
  validates :prefecture_ids, presence: true
  validates :part_ids, presence: true
  validates :genre_ids, presence: true

end
