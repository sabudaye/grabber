require 'spec_helper'

describe 'HtmlParser' do
  before(:each) do
    @parser = Imggrabber::HtmlParser.new('http://www.w3.org')
  end

  it 'should download images' do
    VCR.use_cassette("w3") do
      expect(@parser.images).to be Array
    end
  end
end