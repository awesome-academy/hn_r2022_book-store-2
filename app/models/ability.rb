class Ability
  include CanCan::Ability

  def initialize user
    can %i(read), Book

    if user&.admin?
      can :manage, :all
    elsif user&.user?
      can %i(read create destroy), Order
      can %i(create update destroy), OrderDetail
      can %i(read update), User, id: user.id
    else
      return
    end
  end
end
