class Shurl::App
 
  @@redis = Redis.new(:host => 'localhost')

  def self.call(env)
    request = Rack::Request.new(env)
    response = Rack::Response.new
    response.header['Content-Type'] = "text/plain"
    case request.path
    when "/"
      url = request.params['url']
      uri = URI.parse(url)
      unless uri.kind_of? URI::HTTP or uri.kind_of? URI::HTTPS
        response.status = 500
        response.write "URL is invalid!"
      else
        hash = Zlib.crc32(url)
        unless @@redis.exists(hash)
          @@redis.set(hash, uri.to_s)
          @@redis.hset(:clicks, hash, 0)
        end
        response.status = 200
        response.write "#{request.scheme}://#{request.host_with_port}/#{hash}"
      end
    else
      hash = request.path.delete('/')
      url = @@redis.get(hash)
      unless url.nil? 
        @@redis.hincrby(:clicks, hash, 1)
        response.redirect(url, 301)
      else
        response.status = 404
        response.write "URL with hash #{hash} not found!"
      end
    end 
    response.finish
  end

end