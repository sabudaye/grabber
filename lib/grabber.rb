require 'grabber/version'
require 'grabber/core'
require 'grabber/cli'

module Grabber
  extend self

  def adapters
    ['threads', 'typhoeus']
  end

  def grab(url:, path: './grabber_output', number: 40, adapter: 'threads')
    core = Core.new
    uri = core.parse_url(url)
    html = core.get_html(uri)
    path = core.make_path(path, uri.host).first
    images = core.get_images_url_list(html, uri)
    core.typhoeus_download(number, path, images)
  end
end
