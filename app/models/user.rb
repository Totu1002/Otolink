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

  attachment :profile_image, destroy: false

end
