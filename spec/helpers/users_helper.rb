def log_in user
  session[:user_id] = user.id
end

def log_out
  session[:user_id] = nil
end
