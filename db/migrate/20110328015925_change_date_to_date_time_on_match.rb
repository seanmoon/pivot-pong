class ChangeDateToDateTimeOnMatch < ActiveRecord::Migration
  def self.up
    change_column :matches, :date, :datetime
  end

  def self.down
    change_column :matches, :date, :date
  end
end
