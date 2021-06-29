require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get "/" do
    if logged_in? 
      redirect '/user_page'
    else 
    erb :index
    end 
  end


  get '/delete_all' do 
    User.destroy_all
    "EVERYTHING GONE"
  end 

  get '/user_page/logout' do 
    session.clear
    redirect '/login'
  end 
  

  helpers do

    def logged_in?
        !!session[:user_id]
    end

    def current_user
        @current_user ||= User.find_by_id(session[:user_id])
    end

    def authenticate
     if !logged_in?
        redirect '/'
     end 
    end

    def valid_user_structure?()
    end 

end
end 