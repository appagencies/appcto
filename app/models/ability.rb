class Ability
  include CanCan::Ability

  def initialize(user)

    can :read, :all
    cannot :read, Company, :approved => false

    user ||= User.new

    if user.role == "admin"
      can :access, :rails_admin
      can :dashboard
      can :manage, :all
    elsif user.role == "company"
      can :create, Company
      can :read, Company
      can :update, Company, :user => user
    end

  end
end
