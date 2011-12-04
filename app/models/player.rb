class Player < ActiveRecord::Base
  before_validation :downcase_name, :if => ->{ name.present? }

  validates :name, presence: true, uniqueness: true

  def display_name
    name.split("'").map(&:titleize).join("'")
  end

  private

  def downcase_name
    self.name = self.name.downcase
  end
end
