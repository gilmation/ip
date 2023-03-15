require 'open-uri'

#
# Get the Ip from a remote service
#
URI.open('http://127.0.0.1:9292', :http_basic_authentication=>['admin', '2jozf8xDsYpa']) do |f|
#URI.open('http://localhost:9292', :http_basic_authentication=>['admin', '2jozf8xDsYpa']) do |f|
#URI.open('http://ip.gilmation.com:80', :http_basic_authentication=>['admin', '2jozf8xDsYpa']) do |f|
  puts f.gets
end

