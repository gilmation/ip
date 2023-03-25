# IP
require "yaml"
require "sinatra/base"
require_relative "fig"

class Ip < Sinatra::Base
  # Unless we have externally defined ENV variables i.e. Heroku
  Fig.init unless ENV["bearer"]

  before { authenticate! || halt(401, "Access Denied") }

  helpers do
    def authenticate!
      @bearer ||= ENV["bearer"]
      request.env["HTTP_AUTHORIZATION"] &&
        request.env["HTTP_AUTHORIZATION"] =~ /^Basic.#{@bearer}$/
    end
  end

  # Return the IP
  get "/" do
    request.ip
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
