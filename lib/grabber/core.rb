require 'nokogiri'
require 'grabber/adapters/typhoeus'
require 'grabber/adapters/threads'

module Grabber
  class Core
    def self.adapters
      ['threads', 'typhoeus']
    end
  end
end
