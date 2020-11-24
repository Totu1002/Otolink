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

  enum is_status: {
    公開中: true,
    非公開: false
  }

  validates :title, presence: true
  validates :body, presence: true, length: {maximum: 200}
  validates :article_type, presence: true
  validates :stance, presence: true
  #多対多テーブルの項目も必須
  validates :prefecture_ids, presence: true
  validates :part_ids, presence: true
  validates :genre_ids, presence: true

  #検索機能用scope
  scope :member, -> { where(is_member: "有効") }
  scope :status, -> (user_id) { where(is_status: "公開中",user_id: user_id) }

  #記事の種類
  scope :article_type, -> (article_type) { where(article_type: article_type) }
  #活動方針
  scope :stance, -> (stance) { where(stance: stance) }
  #活動エリア
  scope :search_pref, -> (search_pref) { where(id: search_pref) }
  #担当パート
  scope :search_part, -> (search_part) { where(id: search_part) }
  #ジャンル
  scope :search_genre, -> (search_genre) { where(id: search_genre) }

end
