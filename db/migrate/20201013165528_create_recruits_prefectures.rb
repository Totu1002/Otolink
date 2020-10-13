class CreateRecruitsPrefectures < ActiveRecord::Migration[5.2]
  def change
    create_table :recruits_prefectures do |t|
      t.integer :recruit_id
      t.integer :prefecture_id

      t.timestamps
    end
  end
end
