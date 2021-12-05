class CreateDiveComments < ActiveRecord::Migration[5.2]
  def change
    create_table :dive_comments do |t|
      t.integer :user_id
      t.integer :dive_id
      t.text :comment
      t.integer :reply

      t.timestamps
    end
  end
end
