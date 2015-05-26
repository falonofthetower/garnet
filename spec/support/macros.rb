def current_user
  User.find(session[:user_id])
end

def set_current_user(user=nil)
  session[:user_id] = (user || Fabricate(:user)).id
end

def sign_in(a_user=nil, a_password=nil)
  user = a_user || Fabricate(:user)
  password = a_password || user.password
  visit login_path
  fill_in 'Email Address', :with => user.email
  fill_in 'Password', :with => user.password
  click_button 'Sign in'
end

def create_trial(name)
  visit trials_path
  click_on "Add Trial"
  fill_in "Name of Trial", with: name
  fill_in "Date trial expires", with: Faker::Date.forward(14).to_s
  click_button "Add Trial"
end

def edit_trial(trial_name, new_name)
  trial = Trial.find_by(name: trial_name)

  visit trials_path
  find("a[href='/trials/#{trial.id}/edit']").click
  fill_in "Name of Trial", with: new_name
  click_button "Edit Trial"
end

def sign_out
  visit logout_path
end
