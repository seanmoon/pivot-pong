require 'spec_helper'

describe ApplicationHelper do
  describe "#location" do
    subject { helper.location }

    context "when no location is configured" do
      it { should == "NYC" }
    end

    context "when a location is configured" do
      before do
        ENV["PIVOT_PONG_LOCATION"] = "Starbase Alpha"
      end

      it { should == "Starbase Alpha" }
    end
  end
end
