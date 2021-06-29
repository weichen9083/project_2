class PostsController < ApplicationController

    get '/posts/history' do
        @post = Post.all

        erb :"posts/history"

    end 

    get '/post/new' do 
        erb :"posts/new"
    end 


    post '/posts' do 
        @post = Post.new(params)
        @post.user_id = session[:user_id]
        @post.save 
        redirect "/posts/#{@post.id}"
    end 




    get '/posts/:id/edit' do 
        @post = Post.find_by(id:params[:id])
        if @post !=nil && @post.user == current_user 
            erb :"posts/edit"
        else   
            erb :nice_try  
        end 
        
    end 

    post '/posts/:id' do 
        @post = Post.find_by_id(params[:id])
        if @post !=nil && @post.user == current_user 
            @post.update(content: params[:content])
            redirect '/posts/history'
        else   

            erb :nice_try       
        end 
        
    end 

    get '/posts/:id' do
        erb :'/posts/show'
    end 


    get '/posts/:id/delete' do 
        @post = Post.find_by(id:params[:id])
        if @post !=nil && @post.user == current_user 
            erb :"posts/delete"
        else   
            erb :nice_try  
        end 
        
    end 

    post '/posts/:id/delete' do 
        @post = Post.find_by(id:params[:id])
        if @post !=nil && @post.user == current_user 
            @post.delete
            redirect '/posts/history'
        else   
            erb :nice_try  
        end 

        
    end 

    
end 