# A simple Sinatra app to return the source IP of an HTTP request (uses basic auth)

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
Run some / all of these to test that it's all working
```
rake test
ruby ./ip_client.rb
curl -H "Authorization: Basic $bearer" 127.0.0.1:9292 or $target_fqdm
curl -u admin:$basic_token 127.0.0.1:9292 or $target_fqdm
```
