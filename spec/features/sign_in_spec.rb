feature 'log in page' do
  scenario 'checks that login page is accessible' do
    visit '/'
    click_button("Log In")
    expect(page).to have_content("Please log in")
  end

  scenario 'checks that an existing user is able to login' do
    User.delete_all
    User.create!(
      first_name: 'Willy', 
      last_name: 'Balm', 
      user_name: 'Hilliblilly', 
      email: 'hilly@example.com', 
      password: 'griltheAnim4lz'
    )
    visit '/login'
    fill_in('user_name', with: "Hillibilly")
    fill_in('password', with: "griltheAnim4lz")
    click_button("Log In")
    expect(page).to have_content("Welcome back to MakersBnB!")
  end
end