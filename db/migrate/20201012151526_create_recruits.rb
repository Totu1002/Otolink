class CreateRecruits < ActiveRecord::Migration[5.2]
  def change
    create_table :recruits do |t|

      t.timestamps
      t.integer :user_id
      t.string :type
      t.string :title
      t.text :body
      t.string :area
      t.string :stance
      t.string :gender
      t.string :part
      t.string :genre
      t.boolean :is_status, default: true, null: false
    end
  end
end
