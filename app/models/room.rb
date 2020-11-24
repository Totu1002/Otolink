class Room < ApplicationRecord

  #DM機能用リレーション
  has_many :entries, dependent: :destroy
  has_many :messages, dependent: :destroy

  #DM通知機能
  has_many :notifications, dependent: :destroy
end
