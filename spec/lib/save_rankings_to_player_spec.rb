require 'spec_helper'

describe SaveRankingsToPlayer do
  describe ".run" do
    let!(:p1) { Player.create(name: "Foo") }
    let!(:p2) { Player.create(name: "Bar") }
    let!(:p3) { Player.create(name: "Baz") }
    let!(:p4) { Player.create(name: "Quux") }

    context "when no matches exist" do
      it "doesn't assign ranks" do
        SaveRankingsToPlayer.run
        
        p1.rank.should be_nil
        p2.rank.should be_nil
        p3.rank.should be_nil
        p4.rank.should be_nil
      end
    end

    it "clears out any existing ranks" do
      p3.update_attributes :rank => 3

      SaveRankingsToPlayer.run
      p3.reload.rank.should be_nil
    end

    context "when matches exists" do
      let!(:m1) { Match.create(winner: p1, loser: p2) }

      it "assigns ranks for players in the match" do
        Player.update_all(:active => false)
        SaveRankingsToPlayer.run

        p1.reload.rank.should == 1
        p2.reload.rank.should == 2
        p3.reload.rank.should be_nil
        p4.reload.rank.should be_nil
      end

      context "multiple matches" do
        let!(:m2) { Match.create(winner: p2, loser: p1) }

        it "sorts winners" do
          Player.update_all(:active => false)
          SaveRankingsToPlayer.run

          p1.reload.rank.should == 2
          p2.reload.rank.should == 1
          p3.reload.rank.should be_nil
          p4.reload.rank.should be_nil
        end
      end

      context "moving halfway to the winner" do
        let!(:m2) { Match.create(winner: p2, loser: p3) }
        let!(:m3) { Match.create(winner: p4, loser: p1) }

        it "moves the winner halfway to the loser" do
          Player.update_all :active => true

          SaveRankingsToPlayer.run

          p1.reload.rank.should == 1
          p2.reload.rank.should == 3
          p3.reload.rank.should == 4
          p4.reload.rank.should == 2
        end
      end
    end
  end
end