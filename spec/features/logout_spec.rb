require 'spec_helper'

feature "User logs out" do
  scenario "User logs in and then out" do
    sign_in

    sign_out

    expect(page).to have_content("signed out!")
  end
end
