class CreateUsersPrefectures < ActiveRecord::Migration[5.2]
  def change
    create_table :users_prefectures do |t|
      t.integer :user_id
      t.integer :prefecture_id

      t.timestamps
    end
  end
end
