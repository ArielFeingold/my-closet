class OutfitsController < ApplicationController

  get '/outfits' do
    if logged_in?
      @user = User.find_by(:id => session[:user_id])
      @outfits = @user.outfits
      erb :'outfits/outfits'
    else
      redirect to '/login'
    end
  end

  post '/outfits' do
    if logged_in?
      @outfit = Outfit.new(params[:outfit])
      @outfit.user_id = session[:user_id]
      @outfit.save
      redirect to '/outfits'
    else
      redirect to '/login'
    end
  end

  get '/outfits/new' do
    if logged_in?
      @user = User.find_by(:id => session[:user_id])
      erb :'outfits/new'
    else
      redirect to '/login'
    end
  end

  get '/outfits/:id' do
    if logged_in?
      @outfit = Outfit.find_by(params[:id])
      erb :'outfits/show'
    else
      redirect to '/login'
    end
  end



end
