require 'spec_helper'

describe 'Cli' do
  it 'should run grabber' do
    VCR.use_cassette("w3.org") do
      Imggrabber::Cli.run(['http://www.w3.org'])
    end
    expect(Dir.exist?('./grabber_output/www.w3.org')).to be true
  end
end