describe "matches/rankings.html.haml" do
  let(:me) { Player.create(name: "me", rank: 1) }
  let(:you) { Player.create(name: "you", rank: 2) }
  before do
    assign :rankings, [me, you]
    assign :last_30_days_rankings, ["one", "two"]
    assign :last_90_days_rankings, ["meow", "woof"]
    render
  end
  subject { rendered }
  it { should be }
  it { should include(me.display_name) }
  it { should include(you.display_name) }
  it { should include("one") }
  it { should include("two") }
  it { should include("meow") }
  it { should include("woof") }
  it { should include(link_to "Matches", matches_path) }
end
