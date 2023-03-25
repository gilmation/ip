require "./ip"
require "minitest/autorun"
require "minitest/unit"
require "rack/test"

class Ip_Test < MiniTest::Unit::TestCase
  include Rack::Test::Methods

  def app
    Ip
  end

  def bearer
    @bearer ||= ENV["bearer"]
    @bearer
  end

  def test_my_default
    get "/"
    assert_equal "Access Denied", last_response.body
    assert_equal 401, last_response.status
  end

  def test_with_http_auth
    get "/", {}, "HTTP_AUTHORIZATION" => "Basic #{bearer}"
    assert_equal "127.0.0.1", last_response.body
    assert_equal 200, last_response.status
  end
end
