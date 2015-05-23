require 'spec_helper'

describe 'Core' do
  before(:each) do
    @core = Grabber::Core.new
    @uri = @core.parse_url('http://www.example.com')
    @image_uri = @core.parse_url('http://www.example.com/path/to/image.png')
  end

  it 'should validate url' do
    expect(@core.valid_url?('www.example.com')).to be nil
    expect(@core.valid_url?('http://example.com')).to eq 0
  end

  it 'should download html' do
    expect(@core.get_html(@uri)).not_to be SocketError
    expect(@core.get_html(@uri)).not_to be nil
  end

  it 'should make url' do
    uri = @core.parse_url('http://www.example.com/path/to/image.png')
    expect(@core.to_url('/path/to/image.png', @uri)).to eq uri
  end

  it 'should get images list from html' do
    html = "<html><body><img src='/path/to/image.png'/></body></html>"
    expect(@core.get_images_url_list(html, @uri)).to eq [@image_uri]
  end
end