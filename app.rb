require 'sinatra'
# require 'rack-flash'
require 'sinatra/flash'
require 'sinatra/activerecord'
require 'shotgun'
require 'logger'

ENV['RACK_ENV'] ||= 'development'

set :root, File.dirname(__FILE__)
set :static, true

# Sinatra application
class App < Sinatra::Application
  register Sinatra::ActiveRecordExtension
  enable :sessions
  # use Rack::Session::Cookie
  # use Rack::Flash, :sweep => true, :accessorize => [:success, :info, :warning]

  helpers do
    def protected!
      return if authorized?
    end

    # Checks to see if the user is logged in and is authorized via the session
    def authorized?
      if logged_in? && session[:authorized]
      else
        flash[:danger] = 'You are not authorized to view this page'
        redirect '/'
      end
    end

    # Checks to see the user_id is present in the session
    def logged_in?
      if session[:user_id]
        current_user
      else
        flash[:danger] = 'You must be logged in'
        redirect '/login'
      end
    end

    # Sets the logged in user as the @current user
    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def text_format(text)
      text.to_s.gsub(/\n/, '<br/>')
    end
  end

  require_relative './config/routes'

  configure :development, :production do
    ActiveRecord::Base.logger = Logger.new(STDOUT)
  end

  # Configure Carrierwave
  CarrierWave.configure do |config|
    config.root = File.dirname(__FILE__) + '/public'
  end
end
