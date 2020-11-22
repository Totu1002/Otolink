class UsersPrefecture < ApplicationRecord

  belongs_to :user
  belongs_to :prefecture

  #検索機能用scope
  scope :pref_id, -> (prefecture) { where(prefecture_id: prefecture) }

end
