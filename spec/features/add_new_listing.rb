require 'date'

feature 'adding a new listing' do
  title = 'Beach front villa'

  scenario 'a signed up user can add a new listing' do
    visit("/explore_rooms")
    click_button "add_listing"
    fill_in 'title', with: title
    fill_in 'description', with: '3 bedroom 3 bathroom'
    fill_in 'price_per_night', with: 60
    # add test if datepicker is present
    # expect(page.find('availability_range_min')).to have_content(Date.today.strftime("%Y-%m-%d"))
    # expect(page.find('availability_range_min')).to have_content("October 31, 2015")
    click_button 'add_listing'
    choose('A Radio Button')
    expect(page).to have_content('Please block any unavailable dates from the range previously selected.')
    click_button 'submit_changes_of_listing'
    expect(page).to have_content "#{title} added!"
  end 

  scenario 'a signed up user can add a new listing with dates' do
    visit("/create_listing")
    # expect(page.find('availability_range_min')).to have_content("October 31, 2015")
    # expect(page).to have_content('availability_range_min')
    # fill_in 'availability_range_min', with date
  end

  scenario 'a user is able to view his listing on the feed' do
    visit("/explore_rooms")
    click_button "add_listing"
    fill_in 'title', with: title
    fill_in 'description', with: '3 bedroom 3 bathroom'
    fill_in 'price_per_night', with: 60
    # add test if datepicker is present
    click_button 'add_listing'

    # visit '/explore_rooms'
    # expect(page).to have_content("3 bedroom 3 bathroom")
    # choose('A Radio Button')
    # expect(page).to have_content('Please block any unavailable dates from the range previously selected.')

  end

end