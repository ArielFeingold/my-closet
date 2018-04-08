class OutfitsController < ApplicationController

  get '/outfits' do
    @user = User.find_by(:id => session[:user_id])
    @outfits = @user.outfits
    erb :'outfits/outfits'
  end

  get '/outfits/new' do
    @user = User.find_by(:id => session[:user_id])
    erb :'outfits/new'
  end

  post '/outfits' do
    @outfit = Outfit.new(params[:outfit])
    @outfit.user_id = session[:user_id]
    @outfit.save
    binding.pry
    # params[:outfit][:item_ids].each do |item_id|
    #   binding.pry
    #   item_id = item_id.to_i
    #   item = Item.find_by(:id => params[:outfit][:item_ids][item_id])
    #   @outfit.items << item
    # end
    redirect to '/outfits'
  end

end
