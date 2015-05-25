require 'spec_helper'

describe Grabber do
  it 'has a version number' do
    expect(Grabber::VERSION).not_to be nil
  end

  it 'should return available adapters' do
    expect(Grabber.adapters).to eq ['threads', 'typhoeus']
  end
end
