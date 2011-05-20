  # IP
  require 'yaml'
  require 'sinatra/base'

  class Ip < Sinatra::Base

    use Rack::Auth::Basic, "Gilmation IP Area" do |username, password|
      @basic_config ||= YAML.load_file('./config/basic.yml')
      @admin ||= @basic_config['user']
      @pass ||= @basic_config['password']
      username == @admin && password == @pass
    end

    # Return the IP
    get '/' do
      request.ip
    end

    # start the server if ruby file executed directly
    run! if app_file == $0
  end
  
