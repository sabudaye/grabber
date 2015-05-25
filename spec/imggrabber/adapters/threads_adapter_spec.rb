require 'spec_helper'

describe 'ThreadsAdapter' do
  it 'should run grab images thought threads' do
    Imggrabber::Utils.make_path('./tmp', 'www.w3.org')
    core = Imggrabber::Core.new
    uri = core.parse_url('http://www.w3.org')
    VCR.use_cassette("w3.org") do
      html = core.get_html(uri)
      images = core.get_images_url_list(html, uri)
      Imggrabber::ThreadsAdapter.run(10, './tmp/www.w3.org', images)
    end
    expect(Dir.entries('./tmp/www.w3.org').length).to eq 19
  end
end