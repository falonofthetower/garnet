require 'spec_helper'

feature "User adds trial" do
  scenario "with valid inputs" do
    sign_in
    create_trial "Hulu"

    expect(page).to have_content "Hulu"
  end
end

