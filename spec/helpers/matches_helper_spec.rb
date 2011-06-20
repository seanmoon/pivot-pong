require 'spec_helper'

describe MatchesHelper do
  describe "calculating ranking" do
    subject { helper.calculate_rankings(matches) }

    context "no matches passed in" do
      let(:matches) { [] }
      it { should == [] }
    end

    context "one match passed in" do
      let(:matches) { [Match.create(winner: Player.create(name: 'me'), loser: Player.create(name: 'you'))] }
      it { should == ["Me", "You"] }
    end

    context "multiple matches" do
      let(:matches) do
        p1 = Player.create(name: 'p1')
        p2 = Player.create(name: 'p2')
        [
          Match.create(winner: p1, loser: p2),
          Match.create(winner: p2, loser: p1)
        ]
      end
      it { should == ["P2", "P1"] }
    end

    context "moving halfway to the loser" do
      let(:matches) do
        p1 = Player.create(name: 'p1')
        p2 = Player.create(name: 'p2')
        p3 = Player.create(name: 'p3')
        p4 = Player.create(name: 'p4')
        [
          Match.create(winner: p1, loser: p2),
          Match.create(winner: p2, loser: p3),
          Match.create(winner: p4, loser: p1)
        ]
      end
      it { should == ["P1", "P4", "P2", "P3"] }
    end
    
    it "titleizes the rankings" do
      joe = Player.create(name: 'joe blow')
      jane = Player.create(name: 'jane doe')
      spot = Player.create(name: 'spot')

      helper.calculate_rankings([Match.create(winner: joe, loser: jane), Match.create(winner: joe, loser: spot)]).should ==
        ["Joe Blow", "Jane Doe", "Spot"]
    end
  end
end

