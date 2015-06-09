require 'spec_helper'

describe 'Utils' do
  describe '.make_path' do
    it 'should make path' do
      Imggrabber::Utils.make_path('./tmp', 'www.example.com')
      expect(Dir.exist?('./tmp/www.example.com')).to be true
    end
  end

  describe '.filename' do
    context 'with regular file name' do
      it 'returns original name' do
        image = "http://example.com/path/to/image.png"
        expect(Imggrabber::Utils.filename(image)).to eq 'image.png'
      end
    end

    context 'with long file name' do
      it 'returns slices name' do
        image = "http://example.com/path/to/verylongimagename.png"
        expect(Imggrabber::Utils.filename(image)).to eq 'ngimagename.png'
      end
    end
  end

  describe '.write_file' do
    it 'should write file' do
      image = "http://example.com/path/to/image.png"
      Imggrabber::Utils.make_path('./tmp', 'www.example.com')
      Imggrabber::Utils.write_file('./tmp/www.example.com', image, '')
      expect(File.exist?('./tmp/www.example.com/image.png')).to be true
    end
  end
end