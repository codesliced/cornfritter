get '/' do
end

get '/:screenname' do
  @user = TwitterUser.find_or_create_by_screen_name(params[:screenname])

  if @user.tweets.empty?
    @user.fetch_tweets!
  elsif @user.tweets_stale?
    @user.tweets.destroy_all
    @user.fetch_tweets!
  end
  @last_ten = @user.tweets.limit(10)
  erb :index
end

post '/freshen' do
  @user = TwitterUser.find_or_create_by_screen_name(params[:screenname])
  @user.inspect
  @last_ten = @user.tweets.limit(10)
  erb :_tweets, :layout => false
end



# =============================================
#   Login stuff
# =============================================

get '/login' do
  erb :login
end

get '/signup' do
  erb :signup
end

get '/logout' do
  session.clear
  redirect '/'
end

post '/signup' do
  @user = User.new(params[:user])
  if @user.save
    session[:user] = @user.id
    redirect '/'
  else
    @errors = @user.errors
    puts @user.errors.keys
    erb :signup
  end
end

post '/login' do
  if User.authenticate(params[:user][:name], params[:user][:password])
    @user = User.find_by_name(params[:user][:name])
    session[:user] = @user.id
    redirect '/'
  else
    @errors = {error: "Invalid name or password."}
    erb :login
  end
end
