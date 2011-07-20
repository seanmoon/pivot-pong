class AddRankColumnToPlayers < ActiveRecord::Migration
  def self.up
    add_column :players, :rank, :integer
  end

  def self.down
    remove_column :players, :rank
  end
end
