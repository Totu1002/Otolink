class Genre < ApplicationRecord

  has_many :users_parts
  has_many :users, through: :users_genres

end
