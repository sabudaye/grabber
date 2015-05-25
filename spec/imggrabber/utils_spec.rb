require 'spec_helper'

describe 'Utils' do
  it 'should make path' do
    Imggrabber::Utils.make_path('./tmp', 'www.example.com')
    expect(Dir.exist?('./tmp/www.example.com')).to be true
  end

  it 'should return file name from url to image' do
    image1 = "http://example.com/path/to/image1.png"
    image2 = "http://example.com/path/to/verylongimagename2.png"
    expect(Imggrabber::Utils.filename(image1)).to eq 'image1.png'
    expect(Imggrabber::Utils.filename(image2)).to eq 'gimagename2.png'
  end

  it 'should write file' do
    image = "http://example.com/path/to/image.png"
    Imggrabber::Utils.make_path('./tmp', 'www.example.com')
    Imggrabber::Utils.write_file('./tmp/www.example.com', image, '')
    expect(File.exist?('./tmp/www.example.com/image.png')).to be true
  end
end