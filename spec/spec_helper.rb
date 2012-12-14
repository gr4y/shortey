require 'minitest/autorun'
require 'rack/test'

class MiniTest::Spec
  include Rack::Test::Methods
end

require 'shortey'