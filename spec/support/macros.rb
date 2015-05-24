def current_user
  User.find(session[:user_id])
end

def set_current_user(user=nil)
  session[:user_id] = (user || Fabricate(:user)).id
end
