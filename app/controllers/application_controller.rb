require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    # enable :sessons
    # set :session_secret, "fwitter_secret"
  end

  get '/' do
    erb :index
  end

  helpers do 
    def logged_in?
      !!current_user 
      #returns true if the current user is logged in
    end 
    
    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
      #if current user doesn't exist, then go find it
    end
    
    def logout
      session.clear
    end 
  end 
end
