require './config/environment'
require './models/user'
require './models/rooms'
require './models/availability'
require './models/request'
require './models/printdate'
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

    dates = Availability.new(
      params[:availability_range_min],
      params[:availability_range_max]
    ).range_as_strings

    session[:edit_room_id] = Room.create!(
      title: params[:title],
      description: params[:description],
      price_per_night: params[:price_per_night].to_f,
      picture_url: params[:picture_url],
      availability: dates,
      user_id: session[:current_user].id
    ).id

    @availability = Room.find_by(id: session[:edit_room_id]).availability
    erb :edit_listing
  end

  post '/listings' do
    Room.update_availability(
      session[:edit_room_id],
      unavailable_dates(params)
    )
    @rooms = Room.where(user_id: session[:current_user].id).all
    redirect '/listings'
  end

  get '/listings' do
    @rooms = Room.where(user_id: session[:current_user].id).all
    erb :listings
  end

  get '/explore_rooms' do
    erb :explore_rooms
  end

  post '/explore_filtered_rooms' do
    session[:check_in_start] = params[:check_in_start]
    session[:check_out_end] = params[:check_out_end]
    redirect '/explore_filtered_rooms'
  end 

  get '/explore_filtered_rooms' do
    @filtered_dates = Availability.new(
      session[:check_in_start],
      session[:check_out_end]
      ).range_as_strings
    erb :explore_filtered_rooms
  end

  post '/book' do
    session[:room_id] = params[:room_id]
    redirect '/room'
  end

  get '/room' do
    @max_date = Room.max_available_date(session[:room_id])
    @min_date = Room.min_available_date(session[:room_id])
    @room = Room.find_by(id: session[:room_id])
    erb :room
  end

  get '/requests' do
    erb :requests
  end

  post '/make_request' do
    session[:max_checkout] = Room.max_date_from_min(
      session[:room_id],
      params[:date_from]
    )
    session[:date_from] = params[:date_from]
    redirect '/select_checkout'
  end

  get '/select_checkout' do
    @room = Room.find_by(id: session[:room_id])
    @current_check_in = session[:date_from]
    @max_check_out = session[:max_checkout]
    erb :checkout
  end

  post '/select_checkout' do
    session[:current_request_id] = BookingRequest.create!(
      user_id: session[:current_user].id, 
      room_id: session[:room_id], 
      booking_status: "pending",
      date_from: session[:date_from], 
      date_to: params[:date_to]
      ).id
    if BookingRequest.is_valid(session[:current_request_id]) 
      redirect '/request_confirmation'
    else
      BookingRequest.auto_decline(session[:current_request_id])
      redirect "/auto_decline"
    end
  end

  get "/request_confirmation" do
    @current_request = BookingRequest.find_by(id: session[:current_request_id])
    erb :request_confirmation
  end

  get "/auto_decline" do
    @current_request = BookingRequest.find_by(id: session[:current_request_id])
    erb :auto_decline
  end


  post '/request_response' do
    p params
    BookingRequest.process_request_reponse(params)
    erb :requests
  end

  # get '/edit_listing' do
  #   @availability = string_to_array(Room.last.availability)
  #   erb :edit_listing
  # end


  run! if app_file == $0

end