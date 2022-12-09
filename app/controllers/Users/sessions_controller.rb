# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  before_action :authenticate_user!
  before_action :is_admin?, only: [:edit, :update, :destroy]
  # GET /resource/sign_in
  def new
    byebug
    # binding.pry
  end

  # POST /resource/sign_in
  def create
    byebug
    # binding.pry
  end

  def show
    byebug
  end
  # DELETE /resource/sign_out
  def destroy
    byebug
    # current_user.destroy
    # render 'new'
  end

  def usercreate
    byebug
  end
  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  
  private 
  def is_admin?
    unless current_user.is_admin?
      flash.alert = "Sorry, you don't have permissions to perform this action."
      redirect_to root_path
    end
  end
end
