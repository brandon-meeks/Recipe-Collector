require_relative "../models/models"

get '/' do
  @page_title = ""
  haml :index, layout: :"layouts/main"
end

get '/users' do
  protected!
  @users = User.all
  haml :"users/index", layout: :"layouts/main"
end

# Create new User routes
get '/users/new' do
  @page_title = "New User Signup"
  haml :"users/new", layout: :"layouts/main"
end

post '/users/new' do
  user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])

  if user.save
    redirect "/users"
  else
    redirect 'users/new'
  end
end

# Upate User routes
get '/users/:id' do
  @user = User.find(params[:id])
  haml :"users/show", layout: :"layouts/main"
end

post '/users' do
  user = User.find(params[:user_id])
  user.update(:username => params[:username])
end

# Delete User route
get '/users/:id/delete' do
  user = User.find(params[:id])
  user.delete
  redirect '/users'
end

#Session routes
get '/login' do
  haml :"sessions/new", layout: :"layouts/main"
end

post '/login' do
  authorized_user = User.find_by(username: params[:username])
  if authorized_user && authorized_user.authenticate(params[:password])
    session[:user_id] = authorized_user.id
    flash[:success] = "You have successfully signed in"
    redirect '/'
  else
    redirect '/login'
  end
end

get '/logout' do
  session[:user_id] = nil
  flash[:success] = "You have logged out."
  redirect '/'
end
