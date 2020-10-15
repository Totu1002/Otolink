class CreateUsersGenres < ActiveRecord::Migration[5.2]
  def change
    create_table :users_genres do |t|
      t.integer :user_id
      t.integer :genre_id

      t.timestamps
    end
  end
end
