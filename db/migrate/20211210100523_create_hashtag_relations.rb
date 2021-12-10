class CreateHashtagRelations < ActiveRecord::Migration[5.2]
  def change
    create_table :hashtag_relations do |t|
      t.references :dive, foreign_key: true, index: true
      t.references :hashtag, foreign_key: true, index: true

      t.timestamps
    end
  end
end
