class RecruitsPart < ApplicationRecord

  belongs_to :recruite, optional: true
  belongs_to :part, optional: true

end
