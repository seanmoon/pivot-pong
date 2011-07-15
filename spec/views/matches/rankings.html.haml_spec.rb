describe "matches/rankings.html.haml" do
  before do
    assign :rankings, ["me", "you"]
    assign :last_30_days_rankings, ["one", "two"]
    assign :last_90_days_rankings, ["meow", "woof"]
    render
  end
  subject { rendered }
  it { should be }
  it { should include("me") }
  it { should include("you") }
  it { should include("one") }
  it { should include("two") }
  it { should include("meow") }
  it { should include("woof") }
  it { should include(link_to "Matches", matches_path) }
end
