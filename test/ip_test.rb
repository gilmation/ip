require './ip'
require 'minitest/autorun'
require 'minitest/unit'
require 'rack/test'

class Ip_Test < MiniTest::Unit::TestCase
  include Rack::Test::Methods

  def app
    Ip
  end

  def bearer
    @bearer ||= YAML.load_file( './config/auth.yml' )['bearer']
  end

  def test_my_default
    get '/'
    assert_equal 'Hello World!', last_response.body
  end

  def test_with_http_auth
    get '/', {}, 'HTTP_AUTHORIZATION' => bearer
    assert_equal "127.0.0.1", last_response.body
  end
end