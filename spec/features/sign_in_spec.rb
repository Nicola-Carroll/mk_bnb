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
    fill_in('user_name', with: "Hilliblilly")
    fill_in('password', with: "griltheAnim4lz")
    click_button("Log In")
    expect(page).to have_content("Welcome back Willy!")
    expect(page).to have_content("Logged in as Hilliblilly")
  end

  scenario 'checks that an non existing user is redirected to the invalid login page' do
    visit '/login'
    fill_in('user_name', with: "Willy")
    fill_in('password', with: "Wally")
    click_button("Log In")
    expect(page).to have_content("Invalid username or password, please try again")
  end
end