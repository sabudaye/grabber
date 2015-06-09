require 'imggrabber/version'
require 'imggrabber/html_parser'
require 'imggrabber/cli'
require 'imggrabber/utils'
require 'imggrabber/adapters/typhoeus_adapter'
require 'imggrabber/adapters/threads_adapter'

module Imggrabber
  extend self

  def adapters
    ['threads', 'typhoeus']
  end

  def grab(url:, path: './grabber_output', number: 40, adapter: 'threads')
    parser = HtmlParser.new(url)
    path = Utils.make_path(path, parser.uri.host)
    adapter_for(adapter).run(number, path, parser.images)
  end

  private
  def adapter_for(name)
    raise ArgumentError, "Unknown adapter #{name}" unless adapters.include?(name)
    case name
      when 'threads'
        Adapters::ThreadsAdapter
      when 'typhoeus'
        Adapters::TyphoeusAdapter
    end
  end
end
