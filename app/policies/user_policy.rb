class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if admin?
        scope.all
      else
        scope.none
      end
    end
  end 
end
