require 'spec_helper'

describe Player do
  describe "downcasing names" do
    subject { Player.create(name: "Gregg Van Hove") }
    its(:name) { should == "gregg van hove" }
  end

  it "should validate unique names" do
    Player.create(name: 'p1')
    p = Player.new(name: 'p1')
    p.should_not be_valid
    p.error_on(:name).should be_present
  end

  it "should validate unique ranks" do
    Player.create(name: 'p1', rank: 3)
    p = Player.new(name: 'p2', rank: 3)
    p.should_not be_valid
    p.error_on(:rank).should be_present
  end

  it "requires a name" do
    Player.new.should_not be_valid
  end

  describe '#display_name' do
    subject { Player.create(name: 'scooby doo') }
    its(:display_name) { should == 'Scooby Doo' }
  end

  describe "ranked" do
    let!(:me) { Player.create(name: "me", rank: 2) }
    let!(:you) { Player.create(name: "you", rank: 1) }
    let!(:us) { Player.create(name: "us", rank: nil) }
    subject { Player.ranked }
    it { should == [you, me] }
  end
end
