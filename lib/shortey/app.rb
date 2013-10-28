class Shortey::App < NYNY::App

  before do
    @@redis = Redis.new(:host => 'localhost')
    headers 'Content-Type' => 'application/json'
  end

  after do
    puts "request: #{request}"
  end

  get '/:url' do
    url = params[:url]
    uri = URI.parse(url)

    unless uri.kind_of? URI::HTTP or uri.kind_of? URI::HTTPS
      status 500
      "URL is invalid"
    else
      hash = Zlib.crc32(url)
      unless @@redis.exists(hash)
        @@redis.set(hash, uri.to_s)
        @@redis.hset(:clicks, hash, 0)
      end
      status 200
      "http://#{request}"
    end
  
  end

  get '/:hash' do
    hash = params[:hash]
    url = @@redis.get(hash)
    unless url.nil?
      @@redis.hincrby(:clicks, hash, 1)
      redirect url, 301
    else
      status 404
      "URL with hash #{hash} not found!"
    end
  end

end
