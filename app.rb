require './config/environment'
require './models/user'
require './models/rooms'
require './models/availability'
require_relative 'helper_methods'

require 'date'
require 'sinatra/base'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'yaml'

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

  post '/edit_listing' do

    availability = Availability.new(
      params[:availability_range_min],
      params[:availability_range_max]).range_as_strings

    Room.create!(
      title: params[:title],
      description: params[:description],
      price_per_night: params[:price_per_night].to_f,
      availability: availability,
      user_id: session[:current_user].id
    )
    
    # @availability = string_to_array(Room.last.availability)
    @availability = Room.last.availability
    erb :edit_listing
  end

  post '/listings' do
    p params
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
  
  # get '/edit_listing' do
  #   @availability = string_to_array(Room.last.availability)
  #   erb :edit_listing
  # end


  run! if app_file == $0

end