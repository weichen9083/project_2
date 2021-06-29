class UsersController < ApplicationController


   get '/signup' do    
    if logged_in?
    redirect '/user_page'
    else 
    erb :"users/signup"
    end 
    end 

   post '/signup' do
    user = User.new(params)
    if user.username.blank? || user.password.blank? || user.email.blank? || User.find_by_username(params[:username]) || User.find_by_email(params[:email])
        redirect '/signup'
    else 
    user.save
    session[:user_id] = user.id
    redirect '/login'
    end 
    
   end 

   get '/login' do 
    if logged_in?
        redirect '/user_page'
    else 
    @Wrong = false 
    erb :"users/login"
    end 
   end 

   post '/login' do 
    if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect '/user_page'
    else
        @Wrong = true
        erb :"users/login"
    end
    end 

    get '/user_page' do
        if logged_in? 
            @user= current_user
            erb :"users/user_page"
        else 
            redirect '/'
        end 
    end 

end




