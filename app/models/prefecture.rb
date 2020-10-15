class Prefecture < ApplicationRecord

  has_many :users_prefectures
  has_many :users, through: :users_prefectures

end

