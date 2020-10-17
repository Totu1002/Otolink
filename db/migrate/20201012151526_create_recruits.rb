class CreateRecruits < ActiveRecord::Migration[5.2]
  def change
    create_table :recruits do |t|

      t.timestamps
      t.integer :user_id
      t.integer :article_type
      t.string :title
      t.text :body
      t.integer :stance
      t.integer :gender
      t.boolean :is_status, default: true, null: false
    end
  end
end
