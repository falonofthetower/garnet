require 'spec_helper'

feature "User edits trial" do
  scenario "Signs in and edits trial" do
    sign_in
    create_trial "Hulu"
    edit_trial "Hulu", "Netflix"

    expect(page).to have_content "Netflix"
  end
end

