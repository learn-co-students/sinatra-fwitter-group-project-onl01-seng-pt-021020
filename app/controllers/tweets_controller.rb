class TweetsController < ApplicationController

    get '/tweets' do
        if session[:user_id].nil?
          flash[:message] = 'You must log in to view tweets.'
          redirect '/login'
        end
    
        @user = User.find(session[:user_id])
        @tweets = Tweet.all
    
        erb :'tweets/index'
      end
    
      post '/tweets' do
        
        if params[:content] != ''
          Tweet.create(content: params[:content], user: User.find(session[:user_id]))
          redirect '/tweets'
        end
    
        flash[:message] = "Can't save blank tweet."
        redirect '/tweets/new'
      end
    
      get '/tweets/new' do
        if session[:user_id].nil?
          flash[:message] = 'You must log in to create tweets.'
          redirect '/login'
        end
    
        erb :'tweets/new'
      end
    
      get '/tweets/:id' do
        if session[:user_id].nil?
          flash[:message] = 'You must log in to view tweets.'
          redirect '/login'
        end
    
        @tweet = Tweet.find_by_id(params[:id])
        @owner_view = @tweet.user_id == session[:user_id]
    
        erb :'tweets/show'
      end
    
      patch '/tweets/:id' do
        if params[:content] != ''
          tweet = Tweet.find(params[:id])
          tweet.update(content: params[:content])
          redirect "/tweets/#{tweet.id}"
        else
          flash[:message] = "Can't submit a blank tweet."
          redirect "/tweets/#{params[:id]}/edit"
        end
      end
    
      delete '/tweets/:id' do
        if session[:user_id].nil?
          flash[:message] = 'You must log in to delete tweets.'
          redirect '/login'
        else
          tweet = Tweet.find_by_id(params[:id])
          if tweet && tweet.id == session[:user_id]
            tweet.delete
          end
        end
    
        redirect '/tweets'
      end
    
      get '/tweets/:id/edit' do
        if session[:user_id].nil?
          flash[:message] = 'You must log in to edit tweets.'
          redirect '/login'
        end
    
        @tweet = Tweet.find(params[:id])
        erb :'tweets/edit'
      end

end
