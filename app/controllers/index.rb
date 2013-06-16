# enable :sessions

get '/' do
  erb :index
end

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
