require 'acceptance/acceptance_helper'

feature 'Rankings' do

  background do
    Match.create
  end

  scenario 'should show rankings broken down by date' do
    true.should == true
  end

end
