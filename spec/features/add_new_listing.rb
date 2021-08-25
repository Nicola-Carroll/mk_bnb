feature 'adding a new listing' do
  title = 'Beach front villa'

  scenario 'a signed up user can add a new listing' do
    visit("/explore_rooms")
    click_button "add_listing"
    fill_in 'title', with: title
    fill_in 'description', with: '3 bedroom 3 bathroom'
    fill_in 'price_per_night', with: 60
    click_button 'submit'
    expect(page).to have_content "#{title} added!"
  end 

#   scenario 'a signed up user can list multiple rooms' do
#    "sdfdf"
#   end

end