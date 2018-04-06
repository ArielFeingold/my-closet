class UsersController < ApplicationController

  get '/signup' do
    if !logged_in?
      erb :'users/create_user', locals: {message: "Please sign up before you sign in"}
    else
      erb :'users/show'
    end
  end


    get '/users/:slug' do
      @user = User.find_by_slug(params[:slug])
      erb :'users/show'
    end
  end

  post '/signup' do
    @user = User.create(params)
    session[:user_id] = @user.id
    redirect to "/users/#{@user.slug}"
  end



  get '/logout' do
    if logged_in?
      session.destroy
      redirect to '/login'
    else
      redirect to '/'
    end
  end
