require 'spec_helper'

describe Match do
  describe "setting default date" do
    subject { Match.create }
    let(:occured_at) { Time.parse("2011-03-27") }
    before { Time.stub(:now).and_return(occured_at) }
    its(:occured_at) { should == occured_at }
  end

  describe "validations" do
    subject { Match.create }
    it { should_not be_valid }
  end

  describe "updating player ranks" do
    let!(:p1) { Player.create(name: "p1") }
    let!(:p2) { Player.create(name: "p2") }
    let!(:p3) { Player.create(name: "p3") }
    let!(:p4) { Player.create(name: "p4") }
    let!(:p5) { Player.create(name: "p5", rank: nil) }
    let!(:establishing_match1) { Match.create(winner: p1.reload, loser: p4.reload) }
    let!(:establishing_match2) { Match.create(winner: p3.reload, loser: p4.reload) }
    let!(:establishing_match3) { Match.create(winner: p2.reload, loser: p1.reload) }

    before do
      Match.order(:id).should == [establishing_match1, establishing_match2, establishing_match3]
      establishing_match1.winner.should == p1
      establishing_match1.loser.should == p4

      p1.reload.should be_active
      p2.reload.should be_active
      p3.reload.should be_active
      p4.reload.should be_active
      p5.reload.should be_inactive

      p1.rank.should == 1
      p2.rank.should == 2
      p3.rank.should == 3
      p4.rank.should == 4
      p5.rank.should be_nil
    end

    context "when the players are next to each other" do
      it "should update those players ranks" do
        Match.create(winner: p3, loser: p2)

        p3.reload.rank.should == 2
        p2.reload.rank.should == 3
      end
    end

    context "when the winner moves over a single person" do
      it "should update the ranks correctly" do
        Match.create(winner: p3, loser: p1)

        p1.reload.rank.should == 1
        p3.reload.rank.should == 2
        p2.reload.rank.should == 3
      end
    end

    context "moving halfway to the loser" do
      it "should update intermediary players correctly" do
        Player.update_all :active => true
        Match.create(winner: p4, loser: p1)

        p1.reload.rank.should == 1
        p4.reload.rank.should == 2
        p2.reload.rank.should == 3
        p3.reload.rank.should == 4
      end
    end

    context "when the winner doesn't have a rank yet" do
      it "assigns the correct ranks" do
        Player.update_all :active => true
        Match.create(winner: p5, loser: p2)

        p2.reload.rank.should == 2
        p5.reload.rank.should == 3
        p3.reload.rank.should == 4
        p4.reload.rank.should == 5
      end
    end

    context "when no players have ranks yet" do
      before do
        Player.update_all :rank => nil
      end

      it "should assign the winner to be rank 1 and the loser to rank 2" do
        Match.create(winner: p2, loser: p3)

        p2.reload.rank.should == 1
        p3.reload.rank.should == 2
      end
    end

    context "when other players have ranks, but not the loser does not" do
      it "should not update ranks for the players in this match" do
        Match.create(winner: p4, loser: p5)

        p4.reload.rank.should == 4
        p5.reload.rank.should be_nil
      end
    end
  end

  describe "marking players inactive" do
    let!(:p1) { Player.create(name: "foo") }
    let!(:p2) { Player.create(name: "bar") }
    let!(:p3) { Player.create(name: "baz") }
    let!(:p4) { Player.create(name: "quux") }
    let!(:m1) { Match.create(winner: p4, loser: p2, occured_at: 31.days.ago) }
    let!(:m2) { Match.create(winner: p1, loser: p3, occured_at: 15.days.ago) }

    it "should mark players as inactive who haven't played a game in the last 30 days" do
      Player.update_all :active => true
      p4.should be_active
      Match.create(winner: p2, loser: p3)
      p1.reload.should be_active
      p2.reload.should be_active
      p3.reload.should be_active
      p4.reload.should be_inactive
    end

    it "should mark players as inactive who have never played a game" do
      Player.update_all :active => true
      new_player = Player.create(name: "no matches")
      new_player.should be_active
      Match.create(winner: p2, loser: p3)
      new_player.reload.should be_inactive
    end
  end

  describe "reactivating players" do
    let!(:p1) { Player.create(name: "foo", rank: nil, active: false) }
    let!(:p2) { Player.create(name: "bar", rank: 1, active: true) }

    it "should reactivate inactive players when they win a match" do
      Match.create(winner: p1, loser: p2)
      p1.reload.should be_active
    end

    it "should not reactivate inactive players when the lose a match" do
      Match.create(winner: p2, loser: p1)
      p1.reload.should be_inactive
    end
  end
end
