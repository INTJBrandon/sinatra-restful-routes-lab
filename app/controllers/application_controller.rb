class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # code actions here!
  get '/' do
    redirect to '/recipes'
  end

  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  get '/recipes/new' do
    erb :new
  end

  post '/recipes' do
    puts params
    @recipe = Recipe.create(params)

    redirect "/recipes/#{@recipe.id}"
  end
  

  get '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])
    @recipe_name = @recipe.name
    @recipe_ingredients = @recipe.ingredients
    @recipe_cook_time = @recipe.cook_time
    @recipe_id = @recipe.id

    erb :show
  end

  get '/recipes/:id/edit' do
    @recipe = Recipe.find_by(id: params[:id])
    @recipe_name = @recipe.name
    @recipe_ingredients = @recipe.ingredients
    @recipe_cook_time = @recipe.cook_time
    @recipe_id = @recipe.id

    erb :edit
  end

  patch '/recipes/:id' do
    @recipe = Recipe.find_by(id: params[:id])
    @recipe.update(params)

    erb :show
  end

  delete '/recipes/:id' do
    @recipe = Recipe.find_by(id: params[:id])
    @recipe.delete

    redirect to '/recipes'
  end
end
