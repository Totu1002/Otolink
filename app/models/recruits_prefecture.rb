class RecruitsPrefecture < ApplicationRecord

  belongs_to :recruite, optional: true
  belongs_to :prefecture, optional: true

  #検索機能用scope
  scope :pref_id, -> (prefecture) { where(prefecture_id: prefecture) }

end
