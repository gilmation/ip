# A simple Sinatra / Rack app to return the source IP of an HTTP request.

To run this locally you'll need to add a config/application.yml file,
with the following keys, file which Figaro will then load up:
```
bearer:
basic_token:
```

The following commands can be run to test that it's all working (bundle exec rack up in a separate terminal)

```
bundle exec rackup
rake test
ruby ./ip_client.rb
curl -H "Authorization: Basic $token" $target_fqdm
curl -u admin:$token $target_fqdm
```
