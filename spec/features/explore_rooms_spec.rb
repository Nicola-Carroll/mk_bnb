feature 'exploring all rooms' do
  scenario 'loged in user can filter available rooms by date' do
    visit("/explore_rooms")
    expect(page).to have_content('Filter out available rooms by date')
  end
end