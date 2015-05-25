require 'addressable/uri'
require 'nokogiri'
require 'net/http'

module Imggrabber
  class Core
    def parse_url(url)
      raise ArgumentError, 'Invalid URL' unless valid_url?(url)
      Addressable::URI.parse(url)
    end

    def valid_url?(url)
      url =~ /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/ix
    end

    def get_html(uri)
      Net::HTTP.get(uri)
    end

    def get_images_url_list(html, uri)
      doc = Nokogiri::HTML(html)
      images = []
      doc.css('img').each do |img|
          images << to_url(img.attributes['src'], uri)
      end
      images
    end

    def to_url(src, uri)
      valid_url?(src) ? src : Addressable::URI.join(uri, src)
    end
  end
end
