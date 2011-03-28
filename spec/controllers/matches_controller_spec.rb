require 'spec_helper'

describe MatchesController do
  subject { response }

  describe "GET #index" do
    let(:date) { Time.now }
    let!(:newer_match) { Match.create(winner: "me", loser: "you", date: date) }
    let!(:older_match) { Match.create(winner: "you", loser: "me", date: date - 1.day) }
    before { get :index }
    it { should be_success }
    it { assigns(:matches).should == Match.order("date") }
    it { assigns(:match).should be }
  end

  describe "POST #create" do
    let(:match_params) { {winner: "taeyang", loser: "se7en" } }

    describe "redirection" do
      before { post :create, match: match_params }
      it { should redirect_to(matches_path) }
    end

    it "creates a match" do
      expect { post :create, match: match_params }.to change(Match, :count).by(1)
    end
  end

  describe "PUT #update" do
    let(:match) { Match.create(winner: "gd", loser: "top") }
    let(:valid_params) { { winner: "top", loser: "gd" } }
    before do
      put :update, id: match.to_param, match: valid_params
      match.reload
    end

    it { should redirect_to(matches_path) }

    describe "match" do
      subject { match }
      its(:winner) { should == "top" }
      its(:loser)  { should == "gd" }
    end
  end

  describe "GET #rankings" do
    let(:date) { Time.now }
    let!(:newer_match) { Match.create(winner: "me", loser: "you", date: date) }
    let!(:older_match) { Match.create(winner: "you", loser: "me", date: date - 1.day) }
    before { get :rankings }
    it { should be_success }
    it { assigns(:rankings).should == ["me", "you"] }
  end
end
