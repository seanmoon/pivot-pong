describe "matches/index.html.haml" do
  let(:occured_at) { 2.days.ago }
  let(:match) { Match.create(winner: "cl", loser: "minzy", occured_at: occured_at) }
  before do
    assign :matches, [match]
    assign :match, Match.new
    render
  end
  subject { rendered }
  it { should be }
  it { should include("cl") }
  it { should include("minzy") }
  it { should include(occured_at.strftime("%Y-%m-%d")) }
  it { should include(link_to "Rankings", "/") }
  it { should include(link_to "delete", match_path(match), method: :delete) }
end
