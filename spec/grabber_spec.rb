require 'spec_helper'

describe Grabber do
  it 'has a version number' do
    expect(Grabber::VERSION).not_to be nil
  end

  it 'should return available adapters' do
    expect(Grabber.adapters).to eq ['threads', 'typhoeus']
  end

  it 'should raise argument error, missing keyword' do
    expect { Grabber.grab() }.to raise_error(ArgumentError, 'missing keyword: url')
  end

  it 'should raise argument error, invalid url' do
    expect { Grabber.grab(url: 'www.example.com') }.to raise_error(ArgumentError, 'Invalid URL')
  end
end
