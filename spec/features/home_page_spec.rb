feature 'home page' do
  scenario 'checks the welcome message on the home page' do
    visit '/'
    expect(page).to have_content "Welcome to Makersbnb!"
  end

  scenario 'checks that a new user is able to sign up' do
    visit '/'
    fill_in("first_name", with: "Tom")
    fill_in("last_name", with: "Riddle")
    fill_in("email", with: "marvolo@gmail.com")
    fill_in("user_name", with: "Voldy")
    fill_in("password", with: "WhereIsMrPotter")
    click_button("Sign Up!")
    expect(page).to have_content("Thanks for signing up Tom!")
  end
end