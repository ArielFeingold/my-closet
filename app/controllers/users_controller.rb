class UsersController < ApplicationController

  get '/' do
    if logged_in?
      @user = User.find_by(:id => session[:user_id])
      redirect to "/users/#{@user.slug}"
    else
      erb :index
    end
  end

  get '/signup' do
    if !logged_in?
      erb :'users/create_user'
    else
      @user = User.find_by(:id => session[:user_id])
      redirect to "/users/#{@user.slug}"
    end
  end

  post '/signup' do
    varification = []
      User.all.each do |user|
        if user.email == params[:email]
          varification << user
        end
      end
    if varification.empty?
      @user = User.create(params)
      session[:user_id] = @user.id
      redirect to "/users/#{@user.slug}"
    else
      redirect to '/signup-error'
    end
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
      redirect to "/login-error"
    end
  end

  get '/login-error' do
    erb:'users/login-error'
  end

  get '/signup-error' do
    erb:'users/signup-error'
  end

  get '/logout' do
    if logged_in?
      session.destroy
      redirect to '/'
    else
      redirect to '/login'
    end
  end

  get '/users/:slug' do
    if logged_in?
      @user = User.find_by_slug(params[:slug])
      erb :'users/show'
    else
      redirect to '/login'
    end
  end

  get '/users/:slug/edit' do
    if logged_in?
      @user = User.find_by_slug(params[:slug])
      erb :'users/edit_user'
    else
      redirect to '/login'
    end
  end

  patch '/users/:slug' do
    if logged_in?
      @user = User.find_by_slug(params[:slug])
      if params[:name] != ""
        @user.name = params[:name]
      end
      if params[:password] !=""
        @user.password = params[:password]
      end
      @user.save
      redirect to "/users/#{@user.slug}"
    else
      redirect to '/login'
    end
  end

  get '/test' do
    erb :test
  end

end
