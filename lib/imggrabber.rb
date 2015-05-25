require 'imggrabber/version'
require 'imggrabber/core'
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
    core = Core.new
    uri = core.parse_url(url)
    html = core.get_html(uri)
    path = Utils.make_path(path, uri.host)
    images = core.get_images_url_list(html, uri)
    case adapter
      when 'threads'
        ThreadsAdapter.run(number, path, images)
      when 'typhoeus'
        TyphoeusAdapter.run(number, path, images)
    end
  end
end
