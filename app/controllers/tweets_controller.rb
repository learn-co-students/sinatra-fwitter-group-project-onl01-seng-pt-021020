class TweetsController < ApplicationController
  get '/tweets' do
    if logged_in?
    erb :"/tweets/tweets"
  else
      redirect '/login'      
      end
    end

    get '/tweets/new' do
      if !logged_in?
        redirect to '/login'
      else
      erb :'/tweets/new'
    end
  end

  post '/tweets' do
    @tweet = Tweet.create(content: params[:content])
    if current_user && @tweet.valid?
    @user = current_user
    @user.tweets << @tweet
    @user.save
    
    redirect to "/tweets/#{@tweet.id}"
    else
     
      redirect to '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if logged_in?
  @tweet = Tweet.find_by(id: params[:id])

    erb :'/tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by(id: params[:id])
    erb :'/tweets/edit_tweet'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    @tweet.content = params[:content]
    if @tweet.valid?
    @tweet.save
    redirect to "/tweets/#{@tweet.id}"
    else
      redirect to "/tweets/#{@tweet.id}/edit"
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
  if current_user.tweet_ids.include?(@tweet.id) && logged_in?
    @tweet.destroy
    redirect to '/tweets'
    end
  end

end
