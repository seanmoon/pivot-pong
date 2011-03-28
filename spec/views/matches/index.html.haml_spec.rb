describe "matches/index.html.haml" do
  let(:date) { 2.days.ago }
  let(:match) { Match.create(winner: "cl", loser: "minzy", date: date) }
  before do
    assign :matches, [match]
    assign :match, Match.new
    render
  end
  subject { rendered }
  it { should be }
  it { should include("cl") }
  it { should include("minzy") }
  it { should include(date.to_s) }
  it { should include(link_to "Rankings", rankings_matches_path) }
end
