class ItemsController < ApplicationController

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
      redirect to "/items/#{@item.id}"
    else
      redirect to '/login'
    end
  end

  get '/items/:id/edit' do
    @item = Item.find_by(params)
    erb :'items/edit_item'
  end

  get '/items/:id' do
    if logged_in?
      @item = Item.find_by(params)
      erb :'items/show'
    else
      redirect to '/login'
    end
  end

  patch '/items/:id' do
    if logged_in?
      @item = Item.find_by(:id=> params[:id])
        if @item && @item.user == current_user
          @item.update(name: params[:name], category: params[:category], item_type: params[:item_type], color: params[:color])
          redirect to "/items/#{@item.id}"
        else
          redirect to "/items/#{@item.id}/edit"
        end
      else
        redirect to '/login'
      end
    end


end
