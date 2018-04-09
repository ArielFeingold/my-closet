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
      redirect to '/login'
    end
  end

  get '/items/new' do
    if logged_in?
      erb :'/items/create_item'
    else
      redirect to '/login'
    end
  end

  post '/items' do
    if logged_in?
      @item = Item.new(params)
      @item.user_id = session[:user_id]
      @item.save
      redirect to "/items/#{@item.slug}"
    else
      redirect to '/login'
    end
  end

  get '/items/:slug' do
    if logged_in?
      @item = Item.find_by_slug(params[:slug])
      erb :'items/show'
    else
      redirect to '/login'
    end
  end

  get '/items/:slug/edit' do
    @item = Item.find_by_slug(params[:slug])
    erb :'items/edit_item'
  end

  patch '/items/:slug' do
    if logged_in?
      @item = Item.find_by_slug(params[:slug])
      if @item && @item.user == current_user
        @item.update(name: params[:name], category: params[:category], item_type: params[:item_type], color: params[:color])
        redirect to "/items/#{@item.slug}"
      else
        redirect to "/items/#{@item.slug}/edit"
      end
    redirect to '/login'
    end
  end

  delete '/items/:slug/delete' do
    if logged_in?
      @item = Item.find_by_slug(params[:slug])
      if @item && @item.user == current_user
        @item.delete
      end
      redirect to '/items'
    else
      redirect to '/login'
    end
  end

end
