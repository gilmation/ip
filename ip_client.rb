require 'open-uri'

#
# Get the Ip from a remote service
#
open('http://localhost:4567', :http_basic_authentication=>['admin', '2jozf8xDsYpa']) do |f|
  puts f.gets
end

