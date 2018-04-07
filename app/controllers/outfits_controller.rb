class OutfitsController < ApplicationController

  get '/outfits' do
    erb :'outfits/outfits'
  end
  
end
