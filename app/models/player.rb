class Player < ActiveRecord::Base
  has_many :winning_matches, :class_name => 'Match', :foreign_key => 'winner_id'
  has_many :losing_matches, :class_name => 'Match', :foreign_key => 'loser_id'

  before_validation :downcase_name
  before_save :clear_ranks_for_inactive_players

  validates :name, presence: true
  validates_uniqueness_of :name
  validates_uniqueness_of :rank, :allow_nil => true

  scope :ranked, where('rank IS NOT NULL').order('rank asc')
  scope :active, where(:active => true)
  scope :inactive, where(:active => false)

  def display_name
    name.split("'").map(&:titleize).join("'")
  end

  def most_recent_match
    Match.where(['winner_id = ? OR loser_id = ?', id, id]).order('occured_at desc').first
  end

  def inactive?
    !active?
  end

  def self.compress_ranks
    active.ranked.each_with_index do |player, index|
      new_rank = index + 1
      player.update_attribute(:rank, new_rank) unless new_rank == player.rank
    end
  end

  private

  def downcase_name
    self.name = self.name.downcase if self.name
  end

  def clear_ranks_for_inactive_players
    self.rank = nil if self.inactive?
  end
end
