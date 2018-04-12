class ItemsController < ApplicationController

    get '/items' do
    if logged_in?
      @categories = []
      @items = Item.all.find_all{|i| i.user_id == session[:user_id]}
      @items.each do |item|
        if !@categories.include?(item.category)
          @categories << item.category
        end
      end
      erb :'items/items'
    else
      redirect to '/'
    end
  end

  get '/items/new' do
    @user = User.find_by(:id => session[:user_id])
    if logged_in?
      erb :'/items/create_item'
    else
      redirect to '/'
    end
  end

  post '/items' do
    if logged_in?
      @item = Item.new(params)
      @item.user_id = session[:user_id]
      @item.save
      redirect to "/items"
    else
      redirect to '/'
    end
  end

  get '/items/:id/:slug' do
    if logged_in?
      @item = Item.find_by_id(params[:id])
      erb :'items/show'
    else
      redirect to '/'
    end
  end

  get '/items/:id/:slug/edit' do
    if logged_in?
      @item = Item.find_by_id(params[:id])
      erb :'items/edit_item'
    else
      redirect to '/'
    end
  end

  patch '/items/:id/:slug' do
    if logged_in?
      @user = User.find_by(:id => session[:user_id])
      @item = @user.items.find_by_id(params[:id])
      if @item && @item.user == current_user
        @item.update(name: params[:name], category: params[:category], item_type: params[:item_type], color: params[:color])
        redirect to "/items/#{@item.id}/#{@item.slug}"
      else
        redirect to "/items/#{@item.id}/#{@item.slug}/edit"
      end
    redirect to '/'
    end
  end

  delete '/items/:id/:slug/delete' do
    if logged_in?
      @item = Item.find_by_id(params[:id])
      if @item && @item.user == current_user
        @item.delete
      end
      redirect to '/items'
    else
      redirect to '/'
    end
  end

end
