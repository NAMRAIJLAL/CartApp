class UsercartController < ApplicationController
    load_and_authorize_resource
   
    def edit 
        byebug
    end

    def update 
        
        @usercart = Usercart.find_by(user_id: params[:user_id])
        @items = @usercart.items
        if @items==nil
            if @usercart
                @new={}
                @product=params[:product]
                @price=params[:price]
                @new[@product]=@price
                @usercart.update(items: @new)
                redirect_to store_path(current_user.id)
            else
                flash[:alert]="user has no cart"
            end
        else 
            @new={}
            @product=params[:product]
            @price=params[:price]
            @new[@product]=@price
            @newobj= @new.merge(@items)
            @usercart.update(items: @newobj)
            redirect_to store_path(current_user.id)
        end
    end

    def destroy 
        
        if user_signed_in?
            @usercart = Usercart.find_by(user_id: current_user.id)
            @key = params[:item]
            if @key!=nil
                if @usercart.items.has_key?(@key[0])
                    @usercart.items.delete(@key[0])
                    @usercart.save
                    redirect_to store_path(current_user.id)
                else
                    redirect_to store_path(current_user.id)
                end
            else
                @usercart.items=nil
                @usercart.save
                redirect_to store_path(current_user.id)
            end
        end
    end
end
