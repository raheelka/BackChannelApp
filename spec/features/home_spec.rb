require 'spec_helper'

feature "HomePage" do
  scenario "GET homepage/search" do
    visit root_url
    expect(page).to have_field "s"
    expect(page).to have_select "selectSearch"
  end

  scenario "User creation fields" do
    visit root_url
    expect(page).to have_field "user_first_name"
    expect(page).to have_field "user_last_name"
    expect(page).to have_field "user_username"
    expect(page).to have_field "user_email"
    expect(page).to have_field "user_password"
    expect(page).to have_field "user_password_confirmation"

    page.should have_button "Create User"
  end
end
