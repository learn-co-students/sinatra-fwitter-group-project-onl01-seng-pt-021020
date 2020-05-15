require './config/environment'

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    register Sinatra::Flash
    set :session_secret, 'my_secret'
  end

  enable :sessions


  get '/' do
    erb :index
  end

  get '/signup' do
    if session[:user_id]
      redirect '/tweets'
    end

    erb :signup
  end

  post '/signup' do
    if params[:username] != '' && params[:email] != '' && params[:password] != ''
      user = User.create(params)
      session[:user_id] = user.id
      redirect '/tweets'
    else
      flash[:message] = 'You must provide a username, an email address and a password to sign up.'
      redirect '/signup'
    end
  end

  get '/login' do
    if session[:user_id]
      redirect '/tweets'
    end

    erb :login
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user
      user = user.authenticate(params[:password])
    end

    if user
      session[:user_id] = user.id
      redirect '/tweets'
    else
      flash[:message] = 'Incorrect username/password combination.'
      redirect '/login'
    end
  end

  get '/logout' do
    if !session[:user_id].nil?
      @user = User.find_by_id(session[:user_id])
      erb :logout
    else
      redirect '/'
    end
  end

  post '/logout' do
    username = User.find_by_id(session[:user_id]).username
    session.clear

    flash[:message] = username + ' successfully logged out.'
    redirect to '/login'
  end

end
