class InventoryPolicy < ApplicationPolicy
  attr_reader :user, :inventory

  def create?
    @user.inventory_manager?
  end

  def show?
    @user.inventory_manager?
  end

  def update?
    @user.inventory_manager?
  end

  def destroy?
    @user.inventory_manager?
  end

  class Scope
    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      if user.inventory_manager? || user.sales_manager?
        scope.all
      else
        scope.none
      end
    end

    private

    attr_reader :user, :scope
  end
end