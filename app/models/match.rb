class Match < ActiveRecord::Base
  validates :winner, presence: true
  validates :loser,  presence: true
  validates :date,  presence: true

  before_validation :set_default_date, on: :create

  private

  def set_default_date
    self.date ||= Time.now
  end
end
