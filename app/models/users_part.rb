class UsersPart < ApplicationRecord

  belongs_to :user
  belongs_to :part

  #検索用scope
  scope :part_id, -> (part) { where(part_id: part) }

end
