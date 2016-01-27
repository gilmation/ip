  # IP
  require 'yaml'
  require 'sinatra/base'
  require 'pry'
  # require 'figaro'

  class Ip < Sinatra::Base

    # Figaro.application = Figaro::Application.new( { 'path' => File.join( './', 'config', 'application.yml' ),
    #                                                 'environment' => 'development' } )
    # Figaro.load

    # use Rack::Auth::Basic, "Gilmation IP Area" do |username, password|
    #   @basic_config ||= YAML.load_file('./config/basic.yml')
    #   @admin ||= @basic_config['user']
    #   @pass ||= @basic_config['password']
    #   username == @admin && password == @pass
    # end

    before do
      authenticate! || halt( 401, 'Access Denied' )
    end

    helpers do
      def authenticate!
        @bearer ||= YAML.load_file( './config/auth.yml' )['bearer']
        # @bearer ||= ENV['bearer']
        puts "Bearer helper [#{@bearer}]"
        puts "Bearer request.env [#{request.env}]"
        puts "Bearer http [#{request.env['HTTP_AUTHORIZATION']}]"
        request.env['HTTP_AUTHORIZATION'] && request.env['HTTP_AUTHORIZATION'] =~ /#{@bearer}$/
      end
    end

    # Return the IP
    get '/' do
      request.ip
    end

    # start the server if ruby file executed directly
    run! if app_file == $0
  end