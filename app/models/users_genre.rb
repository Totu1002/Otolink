class UsersGenre < ApplicationRecord

  belongs_to :user
  belongs_to :genre

  #検索用scope
  scope :genre_id, -> (genre_id) { where(genre_id: genre_id) }
end
