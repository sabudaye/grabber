require 'typhoeus'

module Imggrabber
  module Adapters
    class TyphoeusAdapter
      def self.run(number, path, images)
        hydra = Typhoeus::Hydra.new(max_concurrency: number)

        images.length.times do
          image = images.pop
          request = Typhoeus::Request.new image
          request.on_complete do |response|
            Utils.write_file(path, image, response.body)
          end
          hydra.queue request
        end

        hydra.run
      end
    end
  end
end