require 'spec_helper'

describe MatchesHelper do
  describe "calculating ranking" do
    subject { helper.calculate_rankings(matches) }

    context "no matches passed in" do
      let(:matches) { [] }
      it { should == [] }
    end

    context "one match passed in" do
      let(:matches) { [Match.create(winner: "me", loser: "you")] }
      it { should == ["Me", "You"] }
    end

    context "multiple matches" do
      let(:matches) do
        [
          Match.create(winner: "p1", loser: "p2"),
          Match.create(winner: "p2", loser: "p1")
        ]
      end
      it { should == ["P2", "P1"] }
    end

    context "moving halfway to the loser" do
      let(:matches) do
        [
          Match.create(winner: "p1", loser: "p2"),
          Match.create(winner: "p2", loser: "p3"),
          Match.create(winner: "p4", loser: "p1")
        ]
      end
      it { should == ["P1", "P4", "P2", "P3"] }
    end

    it "uses case-insensitive comparisons" do
      helper.calculate_rankings([Match.create(winner: "p1", loser: "P2"), Match.create(winner: "P1", loser: "p2")]).should == ["P1", "P2"]
    end

    it "titleizes the rankings" do
      helper.calculate_rankings([Match.create(winner: "joe blow", loser: "jane doe"), Match.create(winner: "joe blow", loser: "spot")]).should ==
        ["Joe Blow", "Jane Doe", "Spot"]
    end
  end
end

