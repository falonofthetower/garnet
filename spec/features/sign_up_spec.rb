require 'spec_helper'

feature "User signs up" do
  scenario 'with valid email and password' do
    sign_up_with('example@example.com', 'Ex@mp1e')
    expect(page).to have_content('Logout')
  end

  def sign_up_with(email, password)
    visit register_path
    fill_in 'Email Address', with: email
    fill_in 'Password', with: password
    click_button 'Sign Up'
  end
end
