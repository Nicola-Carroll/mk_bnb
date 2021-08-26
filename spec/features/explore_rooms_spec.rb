feature 'checks the explore rooms page' do
  before do
    User.create!(
      first_name: 'Willy', 
      last_name: 'Balm', 
      user_name: 'Hilliblilly', 
      email: 'hilly@example.com', 
      password: 'griltheAnim4lz'
    )
    visit '/login'
    fill_in('user_name', with: "Hilliblilly")
    fill_in('password', with: "griltheAnim4lz")
    click_button("Log In")
    click_button("add_listing")
    fill_in("title", with: "Castle")
    fill_in("description", with: "Big Towers")
    fill_in("price_per_night", with: 50)
    fill_in("availability_range_min", with: "2021-09-11")
    fill_in("availability_range_max", with: "2021-09-13")
    click_button("submit")
  end

  scenario 'adds a new room and checks it appears on the page' do
    visit "/explore_rooms"
    expect(page).to have_content "Castle"
  end

  scenario 'clicks an individual room link' do
    visit "explore_rooms"
    click_button("Book It!")
    expect(page).to have_content "Castle"
  end
end