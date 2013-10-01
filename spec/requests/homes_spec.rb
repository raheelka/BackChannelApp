require 'spec_helper'

describe "HomePage" do
  describe "GET homepage" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get root_url
      response.status.should be(200)
    end
  end
end
