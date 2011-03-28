require 'spec_helper'

describe Match do
  describe "setting default date" do
    subject { Match.create }
    let(:date) { Time.parse("2011-03-27") }
    before { Time.stub(:now).and_return(date) }
    its(:date) { should == date }
  end
end
