class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @user = current_user
      erb :"/tweets/tweets"
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if current_user
      erb :"/tweets/new"
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    tweet = Tweet.create(content: params[:content])
    if tweet.valid?
      tweet.user = current_user
      current_user.tweets << tweet
      current_user.save
      tweet.save
      redirect '/tweets'
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if current_user
      @tweet = Tweet.find(params[:id])
      erb :"/tweets/show_tweet"
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if current_user
      @tweet = Tweet.find(params[:id])
      erb :"/tweets/edit_tweet"
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    tweet = Tweet.find(params[:id])
    tweet.update(content: params[:content])
    if tweet.valid?
    tweet.save
    redirect "/tweets/#{tweet.id}"
    else
      redirect "/tweets/#{tweet.id}/edit"
    end
  end

  delete '/tweets/:id/delete' do
      tweet = Tweet.find(params[:id])
      if tweet && current_user.tweets.include?(tweet)
        tweet.destroy
        redirect '/tweets'
      end
  end

end
