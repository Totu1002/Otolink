class CreateRecruitsGenres < ActiveRecord::Migration[5.2]
  def change
    create_table :recruits_genres do |t|
      t.integer :recruit_id
      t.integer :genre_id

      t.timestamps
    end
  end
end
