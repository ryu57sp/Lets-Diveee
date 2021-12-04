class AddDiverRankToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :diver_rank, :string
  end
end
