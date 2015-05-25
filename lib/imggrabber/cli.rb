require 'optparse'
require 'colorize'

module Imggrabber
  class Cli
    def self.run(args)
      available_adapters = Imggrabber.adapters
      options, output = {}, nil
      no_args = args.empty?

      opt_parser = OptionParser.new do |opt|
        opt.banner = "Usage: grabber 'http://example-url.com' ./path [options]"
        opt.separator ''
        opt.separator 'Specific options:'

        opt.on('-a', '--adapter ADAPTER',"which adapter will be used #{available_adapters}") do |adapter|
          if available_adapters.include?(adapter)
            options[:adapter] = adapter
          else
            output ||= "#{adapter} adapter not available. List of adapters: #{available_adapters}."
          end
        end

        opt.on('-n', '--number NUMBER', 'number of threads or hydras') do |number|
          options[:number] = number
        end

        opt.on('-h', '--help', 'help') do
          output ||= opt_parser
        end

        opt.on('-v', '--version', 'Print version') do
          output ||= 'Grabber version ' << Imggrabber::VERSION
        end
      end
      opt_parser.parse!

      output = opt_parser if no_args

      options[:url] = args[0] unless args[0].nil?
      options[:path] = args[1] unless args[1].nil?

      begin
        Imggrabber.grab(options) if output.nil?
      rescue ArgumentError => e
        puts e.message.red
        puts opt_parser
      end

      puts output unless output.nil?
    end
  end
end
