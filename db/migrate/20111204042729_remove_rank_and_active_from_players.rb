class RemoveRankAndActiveFromPlayers < ActiveRecord::Migration
  def self.up
    remove_column :players, :rank
    remove_column :players, :active
  end

  def self.down
    add_column :players, :active
    add_column :players, :rank
  end
end
