require 'spec_helper'


feature 'Visitor signs up' do
  scenario 'with valid email and password' do
    sign_up_with 'raheel', 'raheel'
    #visit all_post_path
    expect(page).to have_content('Application')
  end

  scenario 'with invalid email' do
    sign_up_with 'invalid_email', 'password'

    expect(page).to have_content('Invalid')
  end

  scenario 'with blank password' do
    sign_up_with 'valid@example.com', ''

    expect(page).to have_content('Invalid')
  end

  def sign_up_with(email, password)
    visit log_in_path
    #pp email
    #pp password
    fill_in 'email_or_username', with: email
    fill_in 'password', with: password
    click_button "Login"
  end
end
feature 'User Signup' do
  def new_signup(fname,lname,uname,email,password,passconfrm)
    visit root_url
    fill_in 'user_first_name' , with: fname
    fill_in 'user_last_name' , with: lname
    fill_in 'user_username' , with: uname
    fill_in 'user_email' , with: email
    fill_in 'user_password' , with: password
    fill_in 'user_password_confirmation' , with: passconfrm
    click_button "Create User"
  end


  scenario 'prpoer credentials' do
    new_signup 'soniya','g','soniya','soniya@abc.com','soniya','soniya'
    expect(page).to have_content('Signed')

  end
end




