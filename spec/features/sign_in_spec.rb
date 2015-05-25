require 'spec_helper'

feature "User signs in" do
  let(:user) { Fabricate(:user) }

  scenario 'with valid email and password' do
    sign_in_with(user.email, user.password)
    expect(page).to have_content('Logout')
  end

  scenario 'with invalid email and password' do
    sign_in_with(user.email, 'not my password')
    expect(page).to have_content('Login')
  end

  def sign_in_with(email, password)
    visit login_path
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    click_button 'Sign in'
  end
end
