require 'spec_helper'

describe ApplicationHelper do
  describe "#location" do
    context "when no location is configured" do
      it "returns nyc" do
        helper.location.should == "NYC"
      end
    end
    
    context "when a location is configured" do
      before do
        ENV["PIVOT_PONG_LOCATION"] = "Starbase Alpha"
      end
      
      it "returns that location" do
        helper.location.should == "Starbase Alpha"
      end
    end
  end
end
