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

  get '/outfits/new' do
    if logged_in?
      @user = User.find_by(:id => session[:user_id])
      erb :'outfits/new'
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

  get '/outfits/:id' do
    if logged_in?
      @outfit = Outfit.find_by(params)
      erb :'/outfits/show'
    else
      redirect to '/login'
    end
  end

  get '/outfits/:id/edit' do
    @user = User.find_by(:id => session[:user_id])
    @outfit = Outfit.find_by(params)
    erb :'outfits/edit_outfit'
  end

  patch '/outfits/:id' do
    if logged_in?
      @outfit = Outfit.find_by(:id=> params[:id])
      @delete = params[:outfit][:delete_items]
      @add = params[:outfit][:add_items]
      @items = @outfit.items

      if @outfit && @outfit.user == current_user
        @outfit.update(name: params[:outfit][:name])
        if @delete != nil
          @delete.each do |i|
            item = Item.find_by(:id => i)
            @items.delete(item)
          end
        end
        if @add != nil
          @add.each do |i|
            item = Item.find_by(:id => i)

            if !@items.include?(item)
              @items << item
            end
          end
        end
        redirect to "/outfits/#{@outfit.id}"
      else
        redirect to "/outfits/#{@outfit.id}/edit"
      end
    redirect to '/login'
    end
  end


end
