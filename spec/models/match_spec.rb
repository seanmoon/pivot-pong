require 'spec_helper'

describe Match do
  describe "associations" do
    context "belongs_to" do
      [:winner, :loser].each do |association|
        it "should belong_to #{association}, class_name: 'Player'" do
          reflection = Match.reflect_on_association(association)
          reflection.macro.should == :belongs_to
          reflection.class_name.should == "Player"
        end
      end
    end
  end

  describe "validations" do
    let(:match) { Match.new }

    before { match.valid? }

    it "should not be valid" do
      match.errors.should include :winner, :loser
    end
  end

  describe "callbacks" do
    context "on create" do
      subject { Match.create }
      let(:occured_at) { Time.parse("2011-03-27") }
      before { Time.stub(:now).and_return(occured_at) }
      its(:occured_at) { should == occured_at }
    end
  end
end
