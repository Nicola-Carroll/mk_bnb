require './config/environment'
require './models/user'
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

  run! if app_file == $0

end