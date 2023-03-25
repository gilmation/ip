## Use Sinatra to return the IP of the incoming HTTP request (uses basic auth)

To run this locally you'll need to add a config/application.yml file,
with the following keys, which Figaro will then load up:
```
bearer:
basic_token:
```

### Terminal 1
```
bundle exec rackup
```
### Terminal 2
Run some / all of these to test that it's all working. Check out the ip.rb file to see the other end point.
```
rake test
ruby ./ip_client.rb
curl -H "Authorization: Basic $bearer" 127.0.0.1:9292/who-am-i or $target_fqdm/who-am-i
curl -u admin:$basic_token 127.0.0.1:9292/who-am-i or $target_fqdm/who-am-i
```
