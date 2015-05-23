require 'fileutils'

module Grabber
  class Utils
    def self.write_file(path, image, body)
      file = File.open("#{path}/#{filename(image)}", "w")
      file.puts(body)
      file.close
    end

    def self.filename(image)
      image_name = image.to_s.split("/").last
      length = image_name.length > 15 ? 15 : image_name.length
      image_name.slice(-length, length)
    end

    def self.make_path(path, host)
      path << "/#{host}"
      FileUtils.mkpath(path).first
    end
  end
end