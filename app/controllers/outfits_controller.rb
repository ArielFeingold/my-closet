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
      erb :'outfits/create_outfit'
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

  get '/outfits/:slug' do
    if logged_in?
      @outfit = Outfit.find_by_slug(params[:slug])
      erb :'/outfits/show'
    else
      redirect to '/login'
    end
  end

  get '/outfits/:slug/edit' do
    @user = User.find_by(:id => session[:user_id])
    @outfit = Outfit.find_by_slug(params[:slug])
    erb :'outfits/edit_outfit'
  end

  patch '/outfits/:slug' do
    if logged_in?
      @outfit = Outfit.find_by_slug(params[:slug])
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
        redirect to "/outfits/#{@outfit.slug}"
      else
        redirect to "/outfits/#{@outfit.slug}/edit"
      end
    redirect to '/login'
    end
  end

  delete '/outfits/:slug/delete' do
    if logged_in?
      @outfit = Outfit.find_by_slug(params[:slug])
      if @outfit && @outfit.user == current_user
        @outfit.delete
      end
      redirect to '/outfits'
    else
      redirect to '/login'
    end
  end


end
