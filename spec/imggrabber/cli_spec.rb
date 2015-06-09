require 'spec_helper'

describe 'Cli' do
  it 'should run grabber' do
    VCR.use_cassette('example') do
      Imggrabber::Cli.run(['http://example.com'])
    end
    expect(Dir.exist?('./grabber_output/example.com')).to be true
  end
end