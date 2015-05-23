require 'spec_helper'
require 'fileutils'

describe 'Cli' do
  it 'should run grabber' do
    Grabber::Cli.run(['http://www.w3.org'])
    expect(Dir.exist?('./grabber_output/www.w3.org')).to be true
    FileUtils.rm_rf('./grabber_output')
  end
end