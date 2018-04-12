class OutfitsController < ApplicationController

  get '/outfits' do
    if logged_in?
      @user = User.find_by(:id => session[:user_id])
      @outfits = @user.outfits
      erb :'outfits/outfits'
    else
      redirect to '/'
    end
  end

  get '/outfits/new' do
    if logged_in?
      @user = User.find_by(:id => session[:user_id])
      erb :'outfits/create_outfit'
    else
      redirect to '/'
    end
  end

  post '/outfits' do
  if logged_in?
    @outfit = Outfit.new(params[:outfit])
    @outfit.user_id = session[:user_id]
    @outfit.save
    redirect to '/outfits'
  else
    redirect to '/'
  end
end

  get '/outfits/:slug' do
    if logged_in?
      @outfit = Outfit.find_by_slug(params[:slug])
      erb :'/outfits/show'
    else
      redirect to '/'
    end
  end

  get '/outfits/:slug/edit' do
    if logged_in?
      @user = User.find_by(:id => session[:user_id])
      @outfit = Outfit.find_by_slug(params[:slug])
      @add_items = @user.items - @outfit.items
      flash[:create_item] = "You need at least one item to update your cart"
      flash[:add_items] = "No items to show. Please add items to edit outfit"
      if @outfit.item_ids.empty? && @user.items.all.empty?
        session[:item_ids] = @outfit.item_ids
        redirect to '/items/new'
      end
      erb :'outfits/edit_outfit'
    end
  end

  patch '/outfits/:slug' do
    if logged_in?
      @user_outfits = Outfit.all.find_all{|outfit| outfit.user_id == session[:user_id]}
      @outfit = @user_outfits.find{|outfit| outfit.slug == params[:slug]}
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
    redirect to '/'
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
      redirect to '/'
    end
  end


end
