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
  it { should include(date.strftime("%Y-%m-%d")) }
  it { should include(link_to "Rankings", "/") }
  it { should include(link_to "delete", match_path(match), method: :delete) }
end
