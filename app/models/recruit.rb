class Recruit < ApplicationRecord

  belongs_to :user

  has_many :recruits_prefecture
  has_many :prefectures, through: :recruits_prefecture

  has_many :recruits_part
  has_many :parts, through: :recruits_part

  has_many :recruits_genre
  has_many :genres, through: :recruits_genre

  enum gender: {
    指定なし: 0,
    男性: 1,
    女性: 2
  }

  enum article_type: {
    メンバー募集: 1,
    バンド募集: 2
  }

  enum stance: {
    プロ志向: 1,
    アマチュア志向: 2
  }
end
