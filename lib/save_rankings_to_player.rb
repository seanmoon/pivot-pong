class SaveRankingsToPlayer
  def self.run
    Player.update_all(:rank => nil)

    ranking = []
    Match.order("occured_at asc").each do |match|
      winner = match.winner
      loser = match.loser

      ranking << winner unless ranking.include? winner
      ranking << loser unless ranking.include? loser

      winner_index = ranking.index(winner)
      loser_index = ranking.index(loser)

      if winner_index > loser_index
        new_index = (winner_index + loser_index) / 2
        ranking.delete_at(winner_index)
        ranking.insert(new_index, winner)
      end
    end

    ranking.each_with_index do |player, index|
      player.update_attributes :rank => index + 1
    end
  end
end