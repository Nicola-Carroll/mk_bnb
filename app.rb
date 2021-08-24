require './config/environment'
require './models/users'
require './models/rooms'
require 'sinatra/base'
require 'sinatra'
require 'sinatra/reloader' if development?

class Mkbnb < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    @users = User.all
    erb :index
  end

  get '/create_listing' do
    erb(:new_listing)
  end

  post '/listings' do
    Rooms.create!(
      title: params[:title],
      description: params[:description],
      price_per_night:params[:price_per_night].to_f,
      user_id: User.all.last.id
    )
    @rooms = Rooms.all
    erb(:listings)
  end


  run! if app_file == $0

end