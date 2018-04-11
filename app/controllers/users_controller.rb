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
      erb :'users/create_user', locals: {message: "Please sign up before you sign in"}
    else
      @user = User.find_by(:id => session[:user_id])
      redirect to "/users/#{@user.slug}"
    end
  end

  post '/signup' do
    if logged_in?
      @user = User.find_by(:id => session[:user_id])
      redirect to "/users/#{@user.slug}"
    else
      @user = User.create(params)
      session[:user_id] = @user.id
      redirect to "/users/#{@user.slug}"
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
    if logged_in?
      @user = User.find_by(:username => params[:username])
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect to "/users/#{@user.slug}"
      else
        redirect to "/signup"
      end
    else
      redirect to '/login'
    end
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
