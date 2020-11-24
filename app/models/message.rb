class Message < ApplicationRecord

  #DM機能用リレーション
  belongs_to :user
  belongs_to :room

  #DM通知機能
  has_many :notifications, dependent: :destroy

end
