require './ip'
require 'minitest/autorun'
require 'minitest/unit'
require 'rack/test'

class Ip_Test < MiniTest::Unit::TestCase
  include Rack::Test::Methods

  def app
    Ip
  end

  def test_my_default
    get '/'
    assert_equal 'Hello World!', last_response.body
  end

  def test_with_rack_env
    get '/', {}, 'HTTP_USER_AGENT' => 'Songbird'
    assert_equal "You're using Songbird!", last_response.body
  end
end