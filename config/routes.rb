require_relative '../models/models'

before do
  current_user
end

get '/' do
  @page_title = ''
  haml :index, layout: :"layouts/main"
end

get '/users' do
  # protected!
  @users = User.all
  haml :"users/index", layout: :"layouts/main"
end

# Create new User routes
get '/users/new' do
  @page_title = 'New User Signup'
  haml :"users/new", layout: :"layouts/main"
end

post '/users/new' do
  user = User.new(
    username: params[:username],
    email: params[:email],
    password: params[:password]
  )

  if user.save
    redirect '/users'
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
  user.update(username: params[:username])
end

# Delete User route
get '/users/:id/delete' do
  user = User.find(params[:id])
  user.delete
  redirect '/users'
end

# Session routes
get '/login' do
  haml :"sessions/new", layout: :"layouts/main"
end

post '/login' do
  authorized_user = User.find_by(username: params[:username])
  if authorized_user && authorized_user.authenticate(params[:password])
    session[:user_id] = authorized_user.id
    flash[:success] = 'You have successfully signed in'
    redirect "/users/#{session[:user_id]}/recipes"
  else
    redirect '/login'
  end
end

get '/logout' do
  session[:user_id] = nil
  flash[:success] = 'You have logged out.'
  redirect '/'
end

# Recipe routes
get '/users/:id/recipes' do
  @user = User.find_by(id: params[:id])
  @recipes = Recipe.where(user_id: @user.id)
  haml :"recipes/index", layout: :"layouts/main"
end

get '/users/:id/recipes/new' do
  @user = User.find_by(id: session[:user_id])
  haml :"recipes/new", layout: :"layouts/main"
end

post '/users/:id/recipes' do
  user = User.find { session[:user_id] }
  recipe = Recipe.create!(
    title: params[:title],
    author: params[:author],
    user_id: params[:user_id],
    procedure: params[:procedure]
  )
  recipe.image = params[:image]
  params[:recipe][:ingredient].each do |ing_data|
    ingredient = Ingredient.new(ing_data)
    ingredient.recipe_id = recipe.id
    ingredient.save
  end
  if recipe.save
    flash[:sucess] = 'Recipe sucessfully saved'
    redirect "/users/#{user.id}/recipes"
  else
    flash[:warning] = 'Unable to create recipe. Please try again.'
    redirect "/users/#{user.id}/recipes/new"
  end
end

get '/users/:id/recipes/:recipe_id' do
  @recipe = Recipe.find(params[:recipe_id])
  @ingredients = Ingredient.where(recipe_id: @recipe.id)
  haml :"recipes/show", layout: :"layouts/main"
end

get '/users/:id/recipes/:recipe_id/edit' do
  @recipe = Recipe.find(params[:recipe_id])
  @ingredients = Ingredient.where(recipe_id: @recipe.id)
  haml :"recipes/edit", layout: :"layouts/main"
end

post '/users/:id/recipes/:recipe_id' do
  recipe = Recipe.find(params[:recipe_id])
  recipe.update(
    title: params[:title],
    image: params[:image],
    procedure: params[:procedure]
  )
  params[:recipe][:ingredient].each do |ing_data|
    ingredient = Ingredient.find(ing_data[:id])
    ingredient.update(
      name: ing_data[:name],
      quantity: ing_data[:quantity],
      qty_type: ing_data[:qty_type]
    )
  end
  if recipe.save
    flash[:success] = 'Recipe successfully updated.'
    redirect "users/#{recipe.user_id}/recipes/#{recipe.id}"
  end
end

get '/users/:id/recipes/:recipe_id/delete' do
  user = User.find { session[:user_id] }
  recipe = Recipe.find(params[:recipe_id])
  recipe.delete
  flash[:success] = 'Recipes successfully deleted'
  redirect "users/#{user.id}/recipes"
end
