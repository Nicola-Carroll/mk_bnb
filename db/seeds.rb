# require 'require_all'
require './models/user'

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

# rooms = [
#   {
#     title: 'Sunny beach hut in Cornwall',
#     description: "5 start luxury hut would recommend",
#     price_per_night: "10000",
#     user_id: 1
#   },
#   {

#   }
# ]