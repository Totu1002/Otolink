class CreateRecruitsParts < ActiveRecord::Migration[5.2]
  def change
    create_table :recruits_parts do |t|
      t.integer :recruit_id
      t.integer :part_id

      t.timestamps
    end
  end
end
