class Recruit < ApplicationRecord

  belongs_to :user

  has_many :recruits_prefecture
  has_many :recruits_part
  has_many :recruits_genre

end
