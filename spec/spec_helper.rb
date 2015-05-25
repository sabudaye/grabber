require 'simplecov'
SimpleCov.start

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'imggrabber'
require 'fileutils'

require 'vcr'
VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock
end

RSpec.configure do |config|
  config.after(:all) do
    FileUtils.rm_rf('./grabber_output')
    FileUtils.rm_rf('./tmp')
  end
end