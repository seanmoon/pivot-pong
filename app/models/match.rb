class Match < ActiveRecord::Base
  validates :winner,      presence: true
  validates :loser,       presence: true
  validates :occured_at,  presence: true

  before_validation :set_default_occured_at_date, on: :create

  private

  def set_default_occured_at_date
    self.occured_at ||= Time.now
  end
end
