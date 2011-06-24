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

  it "clears ranks when players become inactive" do
    p1 = Player.create(name: "foo", rank: 3, active: true)
    p1.should be_active
    p1.rank.should == 3
    p1.update_attributes :active => false
    p1.reload.should be_inactive
    p1.rank.should be_nil
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

  describe ".active and .inactive" do
    let!(:me) { Player.create(name: "me", rank: nil, active: true) }
    let!(:you) { Player.create(name: "you", rank: 1, active: true) }
    let!(:us) { Player.create(name: "us", rank: 2, active: false) }

    it "should scope players correctly" do
      Player.active.should == [me, you]
      Player.inactive.should == [us]
    end
  end

  describe "#most_recent_match" do
    let!(:player) { Player.create(name: "me") }
    subject { player.most_recent_match }
    let!(:opponent) { Player.create(name: "you") }
    let!(:m1) { Match.create(winner: player, loser: opponent) }
    it { should == m1 }

    context "multiple matches" do
      let!(:m2) { Match.create(winner: opponent, loser: player) }
      it { should == m2 }

      context "with retro-actively created matches" do
        let!(:m3) { Match.create(winner: player, loser: opponent, occured_at: 1.day.ago) }
        it { should == m2 }
      end
    end
  end
end
