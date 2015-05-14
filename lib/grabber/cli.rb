require 'optparse'

module Grabber
  class Cli
    def self.run(args)
      available_adapters = Grabber::Core.adapters
      options = {}

      #Default values
      options[:number] = 40
      options[:adapter] = 'threads'

      opt_parser = OptionParser.new do |opt|
        opt.banner = "Usage: grabber 'http://example-url.com' ./path [options]"
        opt.separator ""
        opt.separator "Specific options:"

        opt.on("-a","--adapter ADAPTER","which adapter will be used ['threads', 'typhoeus']") do |adapter|
          if available_adapters.include?(adapter)
            options[:adapter] = adapter
          else
            puts "#{adapter} adapter not available. List of adapters: #{available_adapters}\n"
          end
        end

        opt.on("-n","--number NUMBER","number of threads or hydras") do |number|
          options[:number] = number
        end

        opt.on("-h","--help","help") do
          puts opt_parser
        end
      end

      opt_parser.parse!
    end
  end
end
