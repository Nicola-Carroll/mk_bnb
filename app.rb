require './config/environment'
require './models/user'
require './models/rooms'

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

  post '/register' do
    session[:new_user] = User.create!(
      first_name: params[:first_name], 
      last_name: params[:last_name], 
      email: params[:email], 
      user_name: params[:user_name], 
      password: params[:password]
    )
    redirect '/register'
  end

  get '/register' do
    @new_user = session[:new_user]
    erb :register
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

  get '/logout' do
    @signed_in_user = nil
    redirect '/'
  end

  post '/listings' do
    Room.create!(
      title: params[:title],
      description: params[:description],
      price_per_night: params[:price_per_night].to_f,
      user_id: session[:current_user].id
    )
    @rooms = Room.all
    erb :listings
  end

  post '/book' do
    session[:room] = params[:room]
    redirect '/room'
  end

  get '/room' do
    @room = session[:room]
    erb :room
  end

  get '/requests' do
    erb :requests
  end

  run! if app_file == $0

end