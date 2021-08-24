require './config/environment'
require './models/users'
require 'sinatra/base'
require 'sinatra'
require 'sinatra/reloader' if development?

class Mkbnb < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    @users = User.all
    @users.each { |user| p user.first_name } 
    erb :index
  end

  run! if app_file == $0

end