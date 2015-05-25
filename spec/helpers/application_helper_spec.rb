require 'spec_helper'

RSpec.describe ApplicationHelper, :type => :helper do
  describe "#fix_url" do
    let(:url) { "www.hulu.com" }
    it "returns a url with http:// if it doesn't already include it" do
      url = "www.hulu.com"
      expect(fix_url(url)).to eq("http://#{url}")
    end

    it "returns the url unchanged if it already includes http://" do
      url = "http://www.hulu.com"
      expect(fix_url(url)).to eq(url)
    end
  end
end
