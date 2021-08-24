ENV["SINATRA_ENV"] ||= "development"

require 'bundler/setup'
require 'sinatra/contrib'

Bundler.require(:default, ENV['SINATRA_ENV'])

# configure :development do
#   set :database, 'sqlite3:db/mk_bnb'
# end

if ENV['SINATRA_ENV'] == 'test'
  ActiveRecord::Base.establish_connection(
    adapter: "sqlite3",
    database: "./db/mk_bnb_test"
  )
elsif ENV['SINATRA_ENV'] == 'development'
  ActiveRecord::Base.establish_connection(
    adapter: "sqlite3",
    database: "./db/mk_bnb"
  )
end

#   ActiveRecord::Base.establish_connection(
#     adapter: "sqlite3",
#     database: "./db/mk_bnb"
#   )

require './app'