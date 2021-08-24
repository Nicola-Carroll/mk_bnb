require './config/environment'
<<<<<<< HEAD
require './models/users'
require './models/rooms'
=======
require './models/user'
require './models/rooms'

>>>>>>> c71467c
require 'sinatra/base'
require 'sinatra'
require 'sinatra/reloader' if development?

class Mkbnb < Sinatra::Base
  enable :sessions
  
  configure :development do
    register Sinatra::Reloader
  end

  before do
    @signed_in_user = session[:current_user]
  end

  get '/' do
    erb :index
  end

  get '/login' do
    erb :login
  end

  post '/login' do
    session[:current_user] = User.can_log_in(params[:user_name], params[:password])
    if session[:current_user] == nil
      redirect '/invalid_login'
    else
      redirect '/explore_rooms'
    end
  end

  get '/explore_rooms' do
    erb :explore_rooms
  end

  get '/invalid_login' do
    erb :invalid_login
  end

  get '/create_listing' do
    erb :new_listing
  end

  post '/listings' do
    Room.create!(
      title: params[:title],
      description: params[:description],
      price_per_night:params[:price_per_night].to_f,
      user_id: User.all.last.id
    )
    @rooms = Room.all
    erb :listings
  end


  run! if app_file == $0

end