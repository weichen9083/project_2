class User < ActiveRecord::Base
    has_secure_password
    has_many :posts

    def self.can_be_used?
        if User.find_by(username: params[:username]) || User.find_by(email: params[:email])
            false 
        else 
            true
        end 
    end 


end