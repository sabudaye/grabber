require 'spec_helper'
require 'fileutils'

describe Grabber do
  it 'has a version number' do
    expect(Grabber::VERSION).not_to be nil
  end

  it 'should return available adapters' do
    expect(Grabber.adapters).to eq ['threads', 'typhoeus']
  end

  it 'should grab images thought threads' do
    Grabber.grab(url: 'http://www.w3.org')
    expect(Dir.exist?('./grabber_output/www.w3.org')).to be true
    FileUtils.rm_rf('./grabber_output')
  end

  it 'should grab images thought typhoeus' do
    Grabber.grab(url: 'http://www.w3.org', adapter: 'typhoeus')
    expect(Dir.exist?('./grabber_output/www.w3.org')).to be true
    FileUtils.rm_rf('./grabber_output')
  end
end
