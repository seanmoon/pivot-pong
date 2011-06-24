class AddInactiveToPlayers < ActiveRecord::Migration
  def self.up
    add_column :players, :inactive, :boolean, :default => false
  end

  def self.down
    remove_column :players, :inactive
  end
end
