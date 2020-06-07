class UsersController < ApplicationController

  get '/users' do
    if logged_in?
      @user = current_user
      erb :"/users/show"
    else
      redirect '/login'
    end
  end

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    else
      erb :"/users/create_user"
    end
  end

  post '/signup' do
    user = User.create(username: params[:username], email: params[:email], password: params[:password])
    if user.valid?
      user.save
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
      erb :"/users/login"
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get '/users/:slug' do
      @user = User.find_by_slug(params[:slug])
      erb :"/users/show"
  end

  get '/users/:slug/edit' do
    if current_user
      @user = current_user
      erb :"/users/edit_user"
    else
      redirect '/users'
    end
  end

  patch '/users/:slug' do
    user = current_user
    user.update(params)
    user.save
    redirect "/users/#{user.slug}"
  end

  delete '/users/:slug/delete' do
    if current_user
      User.find(params[:id]).destroy
      session.clear
      redirect '/users'
    else
      redirect '/users'
    end
  end

  get '/logout' do
    session.clear
    redirect '/login'
  end

end
