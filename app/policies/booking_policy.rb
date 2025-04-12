# frozen_string_literal: true

class BookingPolicy < ApplicationPolicy
  def index?
    admin? || user.event_organizer?
  end

  def show?
    admin? || user.event_organizer? || user.customer? && record.customer == user.customer
  end

  def create?
    admin? || user.customer?
  end

  def update?
    admin? || user.event_organizer? || user.customer? && record.customer == user.customer
  end

  def destroy?
    admin? || user.event_organizer? || user.customer? && record.customer == user.customer
  end
end
