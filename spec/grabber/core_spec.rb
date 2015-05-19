require 'spec_helper'
require 'fileutils'

describe 'Core' do
  before(:each) do
    @core = Grabber::Core.new
    @url = @core.parse_url('http://www.example.com')
  end

  it 'should validate url' do
    expect(@core.valid_url?('www.example.com')).to be nil
    expect(@core.valid_url?('http://example.com')).to eq 0
  end

  it 'should make path' do
    @core.make_path('./tmp', @url.host)
    expect(Dir.exist?('./tmp/www.example.com')).to be true
    FileUtils.rm_rf('./tmp')
  end

  it 'should download html' do
    expect(@core.get_html('http://www.example.com').status).to eq ["200", "OK"]
  end
end