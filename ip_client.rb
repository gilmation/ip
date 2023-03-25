require "open-uri"
require "net/http"
require "openssl"
require_relative "fig"

Fig.init

#
# Get the Ip from a remote service
#
URI.open(
  "http://127.0.0.1:9292/who-am-i",
  http_basic_authentication: ["admin", ENV["basic_token"]]
) do |f|
  #URI.open('http://localhost:9292', :http_basic_authentication=>['admin', ENV["basic_token"]]) do |f|
  #URI.open('http://ip.gilmation.com:80', :http_basic_authentication=>['admin', ENV["basic_token"]) do |f|
  puts f.gets
end

uri = URI("http://127.0.0.1:9292/who-am-i")
Net::HTTP.start(uri.host, uri.port) do |http|
  request = Net::HTTP::Get.new uri.request_uri
  request.basic_auth "admin", ENV["basic_token"]

  response = http.request request # Net::HTTPResponse object
  puts response.body
end
