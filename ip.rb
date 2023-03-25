# IP
require "yaml"
require "sinatra/base"
require_relative "fig"

class Ip < Sinatra::Base
  # Unless we have externally defined ENV variables i.e. Heroku
  Fig.init unless ENV["bearer"]

  before "/who-am-i" do
    authenticate! || halt(401, "Access Denied")
  end

  helpers do
    def authenticate!
      @bearer ||= ENV["bearer"]
      request.env["HTTP_AUTHORIZATION"] &&
        request.env["HTTP_AUTHORIZATION"] =~ /^Basic.#{@bearer}$/
    end
  end

  get "/" do
    halt(401, "Access Denied")
  end

  # Return the IP
  get "/who-am-i" do
    request.ip
  end

  set(:probability) { |value| condition { rand <= value } }

  get "/surprise-me", probability: 0.2 do
    "He pulls a knife, you pull a gun,
    he sends one of yours to the hospital,
    you send one of his to the morgue. That's the Chicago way."
  end

  get "/surprise-me", probability: 0.2 do
    "They say we die twice. Once when the breath leaves our body, and once when the last person we know says our name."
  end

  get "/surprise-me" do
    "Who are those guys?"
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
