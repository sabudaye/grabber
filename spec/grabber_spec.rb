require 'spec_helper'

describe Imggrabber do
  it 'has a version number' do
    expect(Imggrabber::VERSION).not_to be nil
  end

  it 'should return available adapters' do
    expect(Imggrabber.adapters).to eq ['threads', 'typhoeus']
  end
end
