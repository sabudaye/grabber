require 'thread'
require 'typhoeus'
require 'addressable/uri'
require 'fileutils'
require 'nokogiri'
require 'net/http'
require 'pry-byebug'

module Grabber
  class Core
    def parse_url(url)
      raise ArgumentError, 'Invalid URL' unless valid_url?(url)
      Addressable::URI.parse(url)
    end

    def valid_url?(url)
      url =~ /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/ix
    end

    def make_path(path, host)
      path << "/#{host}"
      FileUtils.mkpath(path)
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

    def filename(image)
      image_name = image.to_s.split("/").last
      length = image_name.length > 15 ? 15 : image_name.length
      image_name.slice(-length, length)
    end

    def thread_download(number, images)
    end

    def typhoeus_download(number, path, images)
      hydra = Typhoeus::Hydra.new(max_concurrency: number)
      images.length.times do
        image = images.pop
        request = Typhoeus::Request.new image
        request.on_complete do |response|
          file = File.open("#{path}/#{filename(image)}", "w")
          file.puts(response.body)
          file.close
        end
        hydra.queue request
      end
      hydra.run
    end
  end
end
