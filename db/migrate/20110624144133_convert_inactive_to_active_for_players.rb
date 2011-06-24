class ConvertInactiveToActiveForPlayers < ActiveRecord::Migration
  def self.up
    add_column :players, :active, :boolean, :default => true
    execute("UPDATE players SET active = 'false' WHERE inactive = 'true'")
    execute("UPDATE players SET active = 'true' WHERE inactive = 'false'")
    remove_column :players, :inactive
  end

  def self.down
    add_column :players, :inactive, :boolean, :default => false
    execute("UPDATE players SET inactive = 'false' WHERE active = 'true'")
    execute("UPDATE players SET inactive = 'true' WHERE active = 'false'")
    remove_column :players, :active
  end
end
