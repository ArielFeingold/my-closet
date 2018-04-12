require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "my_closet_secret"
    register Sinatra::Flash
  end

  get '/bleh' do
    if flash[:blah]
      # The flash collection is cleared after any request that uses it
      "Have you ever felt blah? Oh yes. #{flash[:blah]} Remember?"
    else
      "Oh, now you're only feeling bleh?"
      redirect to '/outfits'
    end
  end

  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

  end
end
