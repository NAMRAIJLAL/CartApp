# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    
    can [:read], Usercart
    can [:read, :edit, :update,:create], Store if user.is_admin?
    can [:read], User if user.is_admin?
    can [:show], Store if !user.is_admin?
    can [:edit, :update], Store, user_id: user.id

    # if user.is_admin
    #   can :manage, :all
    # elsif !user.is_admin
    #   cannot [:edit, :destroy, :index, :upate], User
    # end
  end

end
