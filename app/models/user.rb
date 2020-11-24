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

  #フォロー機能関連付け
  # フォロー取得
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # フォロワー取得
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

  # 自分がフォローしている人
  has_many :following_user, through: :follower, source: :followed
  # 自分をフォローしている人
  has_many :follower_user, through: :followed, source: :follower

  #DM通知機能
  #自分が作成したDMの通知
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  #自分へ作成されたDMの通知
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy



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

  #検索機能用scope
  scope :member, -> { where(is_member: "有効") }
  scope :nickname, -> (nickname) { where(['name LIKE ?',"%#{nickname}%"]) }
  scope :gender, -> (gender) { where(gender: gender) }
  #活動エリア
  scope :search_pref, -> (search_pref) { where(id: search_pref) }
  #担当パート
  scope :search_part, -> (search_part) { where(id: search_part) }
  #ジャンル
  scope :search_genre, -> (search_genre) { where(id: search_genre) }


  #ゲストサインイン機能アクション
  def self.guest
    user = User.find_or_initialize_by(email: "guest@guest.com") do |user|
      #パスワードランダム生成→固定でもよいか？
      user.name = "guest"
      user.password = SecureRandom.urlsafe_base64
      user.age = 20
      user.gender = "男性"
      user.prefectures = Prefecture.where(name: "東京都")
      user.parts = Part.where(name: "その他")
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

  #フォロー関連処理
  # ユーザーをフォローする
  def follow(user_id)
    follower.create(followed_id: user_id)
  end

  # ユーザーのフォローを外す
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end

  # フォロー確認をおこなう
  def following?(user)
    following_user.include?(user)
  end

end
