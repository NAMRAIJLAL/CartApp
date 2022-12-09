
    
class StoreController < ApplicationController
    # load_and_authorize_resource

    def index     
        #    byebug
        if user_signed_in? 
            @stores = Store.accessible_by(current_ability)
            if can? :read, Store
                @stores
            else
                flash[:alert] = 'You do not have enough access to see the stores.'
                redirect_to store_path(current_user)
            end
        else
            flash[:alert]="not sign in"
            redirect_to new_user_session_path
        end
    end

    def new 
        if user_signed_in? 
            if can? :create, Store
                @store =Store.new()
            else
                flash[:alert]="you have no access to create a new store,"
                redirect_to store_path(current_user)
            end
        else 
            redirect_to new_user_session_path
        end
    end

    def create 
        
        # byebug
        if user_signed_in? 
            if can? :create, Store
                @store = params[:store][:name]
                @cate = params[:store][:category]
                @user = User.find(params[:store][:user_id])
                @price = params[:store][:price].split(',')
                @products = params[:store][:products].split(',')
                @new=[]
                @price.zip(@products).each do |pri,pro|
                    @new.push([pro,pri])
                end
                @hash=Store.new(name: @store, user_id: @user.id) 
                @obj ={}
                @obj[@cate]=@new
                @hash.categories=@obj
                @hash.save
                redirect_to store_index_path
            else
                flash[:alert]="you have no access to create a new store,"
                redirect_to store_path(current_user)
            end
        else
            flash[:alert]="you have no access to create a new store,"
            redirect_to new_user_session_path
        end
    end

   

    def show
        # byebug 
        if user_signed_in?
            @store = Store.find_by(id: params[:id])
            # render :json=> @store 
            # if @store.user_id == current_user.id
                if can? :show, @store 
                        @store = Store.find(params[:id])
                        @usercart= Usercart.find_by(user_id: current_user)
                        # @total=0
                        # if @usercart.items!=nil
                        #     @usercart.items.each do |i|
                        #         @total=i[1].to_i+@total
                        #     end
                        # else
                        #     @total=0
                        # end
                else
                    flash[:alert] = 'You do not have enough access to see the store.'
                    redirect_to store_path(current_user.store.id)
                end
            # else
            #     flash[:alert] = 'You do not have access to see the other stores.'
            #     redirect_to store_path(current_user.store)
            # end
        else
            flash[:alert]="not sign in"
            redirect_to new_user_session_path
        end
    end

    def edit
        if user_signed_in? 
            @s = Store.accessible_by(current_ability)
            if can? :edit, @s
                @store = Store.find(params[:id])
            else
                byebug
                flash[:alert]="not access"
                redirect_to store_path(current_user.store)
            end
        else
            redirect_to new_user_session_path
        end
    end


    def update
        # byebug
        if user_signed_in? 
            @s=Store.accessible_by(current_ability)
            @store = Store.find(params[:id])
            if can? :update, @s
                
                @key = params[:store][:key]
                @cat = params[:store][:cat]
                if @cat==nil
                    if @store.categories.has_key?(@key)
                        if params[:store][:values]==""
                            @store.categories[@key]=[]
                            @store.save
                            redirect_to store_path(@store.id)
                        else 
                            @values = params[:store][:values].split(',')
                            @price = params[:store][:price].split(',')
                            @new=[]
                            @values.zip(@price).each do |v,p|
                                @new.push([v,p])
                            end
                            @store.categories[@key]=@new
                            @store.save
                            redirect_to store_path(@store.id)
                        end
                    else
                        @store.categories[@key]=[]
                        if params[:store][:values]==""
                            @store.categories[@key]=[]
                        else 
                            @values = params[:store][:values].split(',')
                            @price = params[:store][:price].split(',')
                            @new=[]
                            @values.zip(@price).each do |v,p|
                                @new.push([v,p])
                            end
                            @store.categories[@key]=@new
                            @store.save
                            redirect_to store_path(@store.id)
                        end
                    end
                else
                    if @store.categories.has_key?(params[:store][:cat])
                    @store.categories.delete(params[:store][:cat])
                    @store.save
                    redirect_to store_path(params[:id])
                    else
                    redirect_to store_path(params[:id])
                    end   
                end    
            else
                flash[:alert]="'You do not have enough access to update this store" 
                redirect_to store_path(current_user)
            end
        end
    end

    def destroy 
        
        if user_signed_in? && current_user.is_admin
                Store.find(params[:id]).destroy
                redirect_to store_index_path
        else
            redirect_to new_user_session_path
        end
    end
end