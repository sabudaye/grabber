require 'spec_helper'

describe 'HtmlParser' do
  let(:url) { 'http://www.w3.org' }
  let!(:parser) { VCR.use_cassette('w3') { Imggrabber::HtmlParser.new(url) } }

  it 'should download images' do
    expect(parser.images.sample.class).to eq Addressable::URI
  end
end