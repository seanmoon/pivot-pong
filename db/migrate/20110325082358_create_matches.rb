class CreateMatches < ActiveRecord::Migration
  def self.up
    create_table :matches do |t|
      t.string :winner
      t.string :loser
      t.date :date

      t.timestamps
    end
  end

  def self.down
    drop_table :matches
  end
end
