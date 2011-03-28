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
      it { should == ["me", "you"] }
    end

    context "multiple matches" do
      let(:matches) do
        [
          Match.create(winner: "p1", loser: "p2"),
          Match.create(winner: "p2", loser: "p1")
        ]
      end
      it { should == ["p2", "p1"] }
    end

    context "moving halfway to the loser" do
      let(:matches) do
        [
          Match.create(winner: "p1", loser: "p2"),
          Match.create(winner: "p2", loser: "p3"),
          Match.create(winner: "p4", loser: "p1")
        ]
      end
      it { should == ["p1", "p4", "p2", "p3"] }
    end
  end
end

