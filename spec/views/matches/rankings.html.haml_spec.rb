describe "matches/rankings.html.haml" do
  before do
    assign :rankings, ["me", "you"]
    render
  end
  subject { rendered }
  it { should be }
  it { should include("me") }
  it { should include("you") }
  it { should include(link_to "Matches", matches_path) }
end
