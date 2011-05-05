require 'spec_helper'

describe MatchesController do
  subject { response }

  describe "GET #index" do
    let(:occured_at) { Time.now }
    let!(:newer_match) { Match.create(winner: "me", loser: "you", occured_at: occured_at) }
    let!(:older_match) { Match.create(winner: "you", loser: "me", occured_at: occured_at - 1.day) }
    before { get :index }
    it { should be_success }
    it { assigns(:matches).should == Match.order("occured_at desc") }
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

  describe "DELETE #destroy" do
    let!(:match) { Match.create(winner: "gd", loser: "top") }

    it "destroys the given match" do
      expect { delete :destroy, id: match.to_param }.to change(Match, :count).by(-1)
    end

    context "after deletion" do
      before { delete :destroy, id: match.to_param }
      it { should redirect_to(matches_path) }
    end
  end

  describe "GET #rankings" do
    let(:occured_at) { Time.now }
    let!(:newer_match) { Match.create(winner: "me", loser: "you", occured_at: occured_at) }
    let!(:older_match) { Match.create(winner: "you", loser: "me", occured_at: occured_at - 1.day) }
    before { get :rankings }
    it { should be_success }
    it { assigns(:rankings).should == ["Me", "You"] }
  end

  describe "GET #players" do
    before do
      @match1 = Match.create(winner: "danny burkes", loser: "edward hieatt")
      @match2 = Match.create(winner: "davis frank", loser: "parker thompson")
    end

    it "renders a sorted, titleized list of player names" do
      get :players
      response.should be_success
      response.body.should == ["Danny Burkes", "Davis Frank", "Edward Hieatt", "Parker Thompson"].join("\n")
    end

    it "takes a query parameter" do
      get :players, q: "d"
      response.should be_success
      response.body.should == ["Danny Burkes", "Davis Frank"].join("\n")
    end

    it "applies the query parameter case-insensitively" do
      get :players, q: "D"
      response.should be_success
      response.body.should == ["Danny Burkes", "Davis Frank"].join("\n")
    end
  end
end
