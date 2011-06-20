class CreatePlayers < ActiveRecord::Migration
  def self.up
    create_table :players do |t|
      t.string :name

      t.timestamps
    end

    execute("INSERT INTO players (name) SELECT DISTINCT(LOWER(winner)) FROM matches")
    execute("INSERT INTO players (name) SELECT DISTINCT(LOWER(loser)) FROM matches WHERE LOWER(loser) NOT IN (SELECT name FROM players)")

    add_column :matches, :winner_id, :integer
    add_column :matches, :loser_id, :integer

    execute("UPDATE matches SET winner_id = (SELECT players.id FROM players WHERE players.name = LOWER(matches.winner))")
    execute("UPDATE matches SET loser_id = (SELECT players.id FROM players WHERE players.name = LOWER(matches.loser))")

    remove_column :matches, :winner
    remove_column :matches, :loser
  end

  def self.down
    add_column :matches, :winner, :string
    add_column :matches, :loser, :string

    execute("UPDATE matches SET winner = (SELECT players.name FROM players WHERE players.id = matches.winner_id)")
    execute("UPDATE matches SET loser = (SELECT players.name FROM players WHERE players.id = matches.loser_id)")

    remove_column :matches, :winner_id
    remove_column :matches, :loser_id

    drop_table :players
  end
end
