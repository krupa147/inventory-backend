class UserPolicy < ApplicationPolicy
  def create?
    user.IT_admin?
  end

  def show?
    user.IT_admin? || (record.sales_mangager? || user.sales_manager?)
  end

  def update?
    user.IT_admin?
  end

  def destroy?
    user.IT_admin?
  end

  class Scope
    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      if user.IT_admin?
        scope.all
      elsif user.sales_manager?
        scope.salas_manager
      else
        scope.none
      end
    end

    private

    attr_reader :user, :scope
  end
end