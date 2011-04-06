require 'spec_helper'

describe Match do
  describe "setting default date" do
    subject { Match.create }
    let(:occured_at) { Time.parse("2011-03-27") }
    before { Time.stub(:now).and_return(occured_at) }
    its(:occured_at) { should == occured_at }
  end
end
