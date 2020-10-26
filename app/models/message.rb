class Message < ApplicationRecord

  #DM機能用リレーション
  belongs_to :user
  belongs_to :room

end
