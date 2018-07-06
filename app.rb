require 'sinatra'
# require 'rack-flash'
require 'sinatra/flash'
require 'shotgun'
require 'logger'

set :root, File.dirname(__FILE__)

# Sinatra application
class App < Sinatra::Application
  enable :sessions
  # use Rack::Session::Cookie
  # use Rack::Flash, :sweep => true, :accessorize => [:success, :info, :warning]

  helpers do
    def protected!
      return if authorized?
    end

    def authorized?
      if session[:user_id]
      else
        flash[:warning] = 'You must be logged in to view'
        redirect '/login'
      end
    end

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
end
