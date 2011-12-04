class Player < ActiveRecord::Base
  before_validation :downcase_name

  validates :name, presence: true
  validates_uniqueness_of :name

  def display_name
    name.split("'").map(&:titleize).join("'")
  end

  private

  def downcase_name
    self.name = self.name.downcase if self.name
  end
end
