class Player < ActiveRecord::Base
  has_many :winning_matches, :class_name => 'Match', :foreign_key => 'winner_id'
  has_many :losing_matches, :class_name => 'Match', :foreign_key => 'loser_id'

  before_validation :downcase_name

  validates :name, presence: true
  validates_uniqueness_of :name
  validates_uniqueness_of :rank, :allow_nil => true

  scope :ranked, where('rank IS NOT NULL').order('rank asc')

  def display_name
    name.titleize
  end

  private

  def downcase_name
    self.name = self.name.downcase if self.name
  end
end