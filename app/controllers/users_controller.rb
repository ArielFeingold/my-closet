class UsersController < ApplicationController

  get '/' do
    erb :index
  end

  get '/signup' do
    if !logged_in?
      erb :'users/create_user', locals: {message: "Please sign up before you sign in"}
    else
      erb :'users/show'
    end
  end

  post '/signup' do
    @user = User.create(params)
    session[:user_id] = @user.id
    redirect to "/users/#{@user.slug}"
  end

  get '/login' do
    if logged_in?
      @user = User.find_by(:id => session[:user_id])
      redirect to "/users/#{@user.slug}"
    else
      erb :'users/login'
    end
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to "/users/#{@user.slug}"
    else
      redirect to "/signup"
    end
  end

  get '/logout' do
    if self.logged_in?
      session.destroy
      redirect to '/'
    else
      redirect to '/login'
    end
  end

    get '/users/:slug' do
      @user = User.find_by_slug(params[:slug])
      erb :'users/show'
    end
  end
