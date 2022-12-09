class WelcomesController < ApplicationController
    # load_and_authorize_resource
    def index 
        # byebug
        if user_signed_in?
            @users = User.all
            if can? :read, User
                @users
            
            else
                flash[:alert] = 'You do not have enough access to see the stores.'
                redirect_to  store_path(current_user.store.id)
            end
        else
            redirect_to new_user_session_path
        end     
    end

    def show
        if user_signed_in? 
            # if !current_user.is_admin
            #     flash[:alert]= "only admin can access"
            #     redirect_to store_path(current_user)
            # else
                @users =User.all
            # end
        else
        redirect_to new_user_session_path
        end
        
    end

    def new 
        if user_signed_in? 
            # && current_user.is_admin 
            @user = User.new
        else
            redirect_to new_user_session_path
        end
    end
    
    def create
        @user =User.new(email: params[:user][:email], password: params[:user][:password], username: params[:user][:username])
        @user.save
        @usercart = Usercart.new(user_id: @user.id)
        @usercart.save
        redirect_to welcomes_path
    end

    def edit 
        if user_signed_in? 
            # && current_user.is_admin 
            @user = User.find(params[:id])
        else
            redirect_to new_user_session_path
        end
    end

    def update
        if user_signed_in? 
            # && current_user.is_admin 
            @user = User.find(params[:id])
            @user.update(email: params[:user][:email], password: params[:user][:password], username: params[:user][:username])
            redirect_to welcomes_path
        else
            redirect_to new_user_session_path
        end
    end

    def destroy 
        if user_signed_in? 
            # && current_user.is_admin 
            @user = User.find(params[:id])
            @user.destroy
            redirect_to welcome_path
        else
            redirect_to new_user_session_path
        end
    end
    
end