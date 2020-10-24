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

  enum is_member: {
    有効: true,
    無効: false
  }

  validates :name, presence: true, length: {maximum: 100}
  validates :introduction, length: {maximum: 500}
  validates :gender, presence: true
  validates :age, presence: true
  #多対多テーブルの項目も必須
  validates :prefecture_ids, presence: true
  validates :part_ids, presence: true
  validates :genre_ids, presence: true

  #ゲストサインイン機能アクション
  def self.guest
    #user = User.find_or_create_by!(email: "guest@guest.com") do |user|
    user = User.find_or_initialize_by(email: "guest@guest.com") do |user|
      #パスワードランダム生成→固定でもよいか？
      user.name = "guest"
      user.password = SecureRandom.urlsafe_base64
      user.age = 20
      user.gender = "男性"
      #これだとテーブルに追加してしまう
      #user.prefectures.build(name: "東京都")
      user.prefectures = Prefecture.where(name: "東京都")
      #user.parts.build(name: "その他")
      user.parts = Part.where(name: "その他")
      #user.genres.build(name: "その他")
      user.genres = Genre.where(name: "その他")
      #Confirmable を使用している場合は必要
      #user.confirmed_at = Time.now
      user.save!
    end
  end

  #退会ユーザーのログインを不可にする(inactive_messageメソッド)
  #Userのis_memberカラムが有効ならログイン可能
  def active_for_authentication?
    super && (self.is_member == "有効")
  end

end
