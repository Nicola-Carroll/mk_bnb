# require 'require_all'
require './models/users'

users = [
  { first_name: 'sir david', 
    last_name: 'attenborough', 
    user_name: 'AttyBoi', 
    email: 'david@example.com', 
    password: 'freetheAnim4lz'
  },
  { first_name: 'Super', 
    last_name: 'Hans', 
    user_name: 'Hansi', 
    email: 'hansi@example.com', 
    password: 'griltheAnim4lz'
  }
]

users.each do |user|
  User.create(user)
end