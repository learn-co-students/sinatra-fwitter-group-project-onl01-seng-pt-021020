class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect to "/tweets"
    else
    erb :'/users/create_user'
    end
  end

  post '/signup' do
    @user = User.new(username: params[:username], email: params[:email], password: params[:password])
    if @user.save
    session[:user_id] = @user.id
    redirect to "/tweets"
    else 
      redirect to '/signup'
    end
  end

  get '/login' do
  if logged_in?

    redirect to '/tweets'
  else
    erb :'/users/login'
    end
  end

  post '/login' do 
  @user = User.find_by(username: params[:username])
  if @user && @user.authenticate(params[:password])
    session[:user_id] = @user.id
    redirect to '/tweets'
  else
    redirect '/login'
    end
  end

  get '/users' do
  redirect to "/users/#{@user.slug}"
  end

  get '/users/:slug' do
  
  @user = User.find_by_slug(params[:slug])
  erb :'/users/show'
  end


  get '/users/:slug/edit' do
  @user = current_user

    erb :'users/edit'
  end

  patch '/users/:slug' do
    @user = current_user
    if @user.save
      redirect "/users/#{@user.slug}"
    else
      redirect to "/users/#{@user.slug}"
    end
  end

  delete '/users/:id/delete' do
  if current_user
    current_user.destroy
    session.clear
    redirect '/'
  else
    redirect to "/users/#{current_user.slug}"
  end
end

  get '/logout' do
  if logged_in?
    session.clear
    redirect to '/login'
  else
    redirect to '/'
  end
end

end
