# require './models/user'

# feature 'landing page' do
#   scenario 'lists users' do
#     User.create!(
#       first_name: 'Willy', 
#       last_name: 'Balm', 
#       user_name: 'Hilliblilly', 
#       email: 'hilly@example.com', 
#       password: 'griltheAnim4lz'
#     )
#     visit '/'
#     expect(page).to have_content 'Hilliblilly'
#   end
# end