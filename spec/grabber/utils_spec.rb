require 'spec_helper'
require 'fileutils'

describe 'Utils' do
  it 'should make path' do
    Grabber::Utils.make_path('./tmp', 'www.example.com')
    expect(Dir.exist?('./tmp/www.example.com')).to be true
    FileUtils.rm_rf('./tmp')
  end
end