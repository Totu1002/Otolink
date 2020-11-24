class RecruitsPart < ApplicationRecord

  belongs_to :recruite, optional: true
  belongs_to :part, optional: true

  #検索用scope
  scope :part_id, -> (part) { where(part_id: part) }

end
