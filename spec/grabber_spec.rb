require 'spec_helper'

describe Grabber do
  it 'has a version number' do
    expect(Grabber::VERSION).not_to be nil
  end

  it 'has hello core method' do
    expect(Grabber::Core.hello).to eq "hello"
  end
end
