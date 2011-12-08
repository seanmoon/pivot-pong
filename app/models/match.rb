class Match < ActiveRecord::Base
  validates :winner,      presence: true
  validates :loser,       presence: true

  belongs_to :winner, :class_name => 'Player'
  belongs_to :loser, :class_name => 'Player'

  before_validation :set_default_occured_at_date, on: :create, :unless => ->{ occured_at.present? }

  private

  def set_default_occured_at_date
    self.occured_at = Time.now
  end
end
