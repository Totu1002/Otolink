class RecruitsGenre < ApplicationRecord

  belongs_to :recruite, optional: true
  belongs_to :genre, optional: true

end
