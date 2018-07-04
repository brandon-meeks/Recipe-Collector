require "sinatra"
#require "rack-flash"
require "sinatra/flash"
require "shotgun"
require "logger"

set :root, File.dirname(__FILE__)


class App < Sinatra::Application
  enable :sessions
  #use Rack::Session::Cookie
  #use Rack::Flash, :sweep => true, :accessorize => [:success, :info, :warning]


  helpers do
    def protected!
      return if authorized?
    end
    def authorized?
      if session[:user_id]
        return true
      else
        flash[:warning] = "You must be logged in to view"
        redirect "/login"
      end
    end
  end

  require "./config/routes"

configure :development, :production do
  ActiveRecord::Base.logger = Logger.new(STDOUT)
end

end
