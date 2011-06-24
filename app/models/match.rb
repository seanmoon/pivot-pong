class Match < ActiveRecord::Base
  validates :winner,      presence: true
  validates :loser,       presence: true
  validates :occured_at,  presence: true

  belongs_to :winner, :class_name => 'Player'
  belongs_to :loser, :class_name => 'Player'

  before_validation :set_default_occured_at_date, on: :create

  after_save :update_player_ranks
  after_save :mark_inactive_players

  private

  def set_default_occured_at_date
    self.occured_at ||= Time.now
  end

  def update_player_ranks
    if Player.sum(:rank) == 0
      winner.update_attributes :rank => 1, :active => true
      loser.update_attributes :rank => 2, :active => true
      return
    elsif loser.rank.nil?
      return
    end
    
    winner_rank = winner.rank || Player.maximum(:rank) + 1
    if winner_rank > loser.rank
      new_rank = (winner_rank + loser.rank) / 2
      winner.update_attributes :rank => nil
      Player.where(['rank < ? AND rank >= ?', winner_rank, new_rank]).order('rank desc').each do |player|
        player.update_attributes :rank => player.rank + 1
      end
      winner.update_attributes :rank => new_rank, :active => true
    end
  end

  def mark_inactive_players
    cutoff = 30.days.ago
    Player.active.each do |player|
      if player.most_recent_match.nil? || (player.most_recent_match.occured_at < cutoff)
        player.update_attributes :active => false
      end
    end
  end
end
