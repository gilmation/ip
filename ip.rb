  # IP
  require 'yaml'
  require 'sinatra/base'
  require 'pry'
  require 'figaro'

  class Ip < Sinatra::Base

    # Unless we have externally defined ENV variables i.e. Heroku
    unless ENV['bearer']
      Figaro.application = Figaro::Application.new( { 'path' => File.join( './', 'config', 'application.yml' ) } )
      Figaro.load
    end

    before do
      authenticate! || halt( 401, 'Access Denied' )
    end

    helpers do
      def authenticate!
        @bearer ||= ENV['bearer']
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