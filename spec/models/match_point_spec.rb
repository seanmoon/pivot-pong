require 'spec_helper'

describe MatchPoint do
  describe ".rankings" do
    subject { MatchPoint.rankings }

    let(:player1) { Player.create name: "player1" }
    let(:player2) { Player.create name: "player2" }

    before do
      Match.create winner: player1, loser: player2 # spread = 0, +8 player1
      Match.create winner: player1, loser: player2 # spread = 8, +8 player1
      Match.create winner: player1, loser: player2 # spread = 16, +7 player1
      Match.create winner: player1, loser: player2 # spread = 23, +7 player1
      Match.create winner: player1, loser: player2 # spread = 30, +7 player1
      Match.create winner: player2, loser: player1 # spread = 37, +10 player2
    end

    it { should == [[player1, 37], [player2, 10]] }
  end

  describe ".points_exchanged" do
    subject { MatchPoint.points_exchanged(spread, result) }

    let(:range) { MatchPoint::POINT_CHART.keys.sample }
    let(:spread) { [*range].sample }

    context "when the result is :upset" do
      let(:result) { :upset }
      it { should == MatchPoint::POINT_CHART[range][:upset] }
    end

    context "when the result is :expected" do
      let(:result) { :expected }
      it { should == MatchPoint::POINT_CHART[range][:expected] }
    end
  end
end
