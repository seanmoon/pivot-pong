require 'spec_helper'

describe Player do
  describe "downcasing names" do
    subject { Player.create(name: "Gregg Van Hove") }
    its(:name) { should == "gregg van hove" }
  end

  it "should validate unique names" do
    Player.create(name: 'p1')
    Player.new(name: 'p1').should_not be_valid
  end

  it "requires a name" do
    Player.new.should_not be_valid
  end

  describe '#display_name' do
    subject { Player.create(name: 'scooby doo') }
    its(:display_name) { should == 'Scooby Doo' }
  end
end
