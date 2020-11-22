class RecruitsGenre < ApplicationRecord

  belongs_to :recruite, optional: true
  belongs_to :genre, optional: true

  #検索用scope
  scope :genre_id, -> (genre_id) { where(genre_id: genre_id) }

end
