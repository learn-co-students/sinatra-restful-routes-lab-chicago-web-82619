class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # code actions here!

  get '/recipes/?' do
    @recipes = Recipe.all
    erb :index
  end

  get '/recipes/new/?' do
    erb :'recipes/new'
  end

  post '/recipes' do
    recipe = Recipe.new(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
    recipe.save
    redirect :"/recipes/#{recipe.id}"
  end

  get '/recipes/:id' do
    @recipe = find_recipe
    erb :'recipes/show'
  end

  get '/recipes/:id/edit' do
    @recipe = find_recipe
    erb :'recipes/edit'
  end

  patch '/recipes/:id' do
    recipe = find_recipe
    recipe.assign_attributes(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
    recipe.save
    redirect :"/recipes/#{recipe.id}"
  end

  delete '/recipes/:id' do
    recipe = find_recipe
    recipe.destroy
    redirect '/recipes'
  end



  def find_recipe
    Recipe.find_by(id: params[:id])
  end

end
