feature 'checks the explore rooms page' do
  before do
    will = User.create!(
      first_name: 'Willy', 
      last_name: 'Balm', 
      user_name: 'Hilliblilly', 
      email: 'hilly@example.com', 
      password: 'griltheAnim4lz'
    )
    Room.create!(
      title: 'Spooky Castle', 
      description: 'very scary and cold',
      price_per_night: 10, 
      user_id: will.id, 
      availability: [
        "2021-01-01",
        "2021-01-02",
        "2021-01-03",
        "2021-01-04",
        "2021-01-05",
      ]
    )
    visit '/login'
    fill_in('user_name', with: "Hilliblilly")
    fill_in('password', with: "griltheAnim4lz")
    click_button("Log In")
  end

  scenario 'adds a new room and checks it appears on the page' do
    visit "/explore_rooms"
    expect(page).to have_content "Spooky Castle"
  end

  # scenario 'clicks an individual room link' do
  #   visit "/explore_rooms"
  #   click_button("#{Room.last.id}")
  #   expect(page).to have_content "Spooky Castle"
  # end

  feature 'exploring all rooms' do
    scenario 'loged in user can filter available rooms by date' do
      visit("/explore_rooms")
      expect(page).to have_content('Filter out available rooms by date')
    end
  end
  
end

