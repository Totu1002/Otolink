class RecruitsPrefecture < ApplicationRecord

  belongs_to :recruite, optional: true
  belongs_to :prefecture, optional: true

end
