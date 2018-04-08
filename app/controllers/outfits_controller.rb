class OutfitsController < ApplicationController

  get '/outfits' do
    @user = User.find_by(:id => session[:user_id])
    @outfits = @user.outfits
    erb :'outfits/outfits'
  end

  post '/outfits' do
    @outfit = Outfit.new(params[:outfit])
    @outfit.user_id = session[:user_id]
    @outfit.save
    redirect to '/outfits'
  end

  get '/outfits/:id' do
    @outfit = Outfit.find_by(params[:id])
    # binding.pry
    erb :'outfits/show'
  end

  get '/outfits/new' do
    @user = User.find_by(:id => session[:user_id])
    erb :'outfits/new'
  end



end
