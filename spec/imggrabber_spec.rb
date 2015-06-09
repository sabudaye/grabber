require 'spec_helper'

describe Imggrabber do

  let(:url) { 'http://example.com' }

  it 'has a version number' do
    expect(Imggrabber::VERSION).not_to be nil
  end

  it 'should return available adapters' do
    expect(Imggrabber.adapters).to eq ['threads', 'typhoeus']
  end

  it 'should grab' do
    VCR.use_cassette('example') do
      described_class.grab(url: url, number: 42)
    end
    expect(Dir.exist?('./grabber_output/example.com')).to be true
  end
end


