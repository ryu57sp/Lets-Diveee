class CreateDives < ActiveRecord::Migration[5.2]
  def change
    create_table :dives do |t|

      t.integer :user_id
      t.string :image_id
      t.string :title
      t.text :body
      t.string :dive_point
      t.string :water_temperature
      t.string :maximum_depth
      t.string :season
      t.string :dive_shop



      t.timestamps
    end
  end
end
