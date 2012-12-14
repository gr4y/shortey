require 'spec_helper'

def app
  Shortey::App
end

describe "Shortey::App" do

  describe 'when I enter an valid URL' do

    it 'should return an hash' do
      url = 'http://google.de'
      request '/', :params => { 'url' => url }
      last_response.status == 200
      uri = URI.parse(last_response.body)
      uri.path.delete('/') == Zlib.crc32(url)
    end

  end

  describe 'when I enter an invalid URL' do

    it 'should return error 500' do
      request '/', :params => { 'url' => 'ftp://mapple.com' }
      last_response.status == 500
      last_response.body == "URL is invalid!"
    end

  end

end