# frozen_string_literal: true

# app/policies/event_policy.rb
class EventPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.event_organizer?
  end

  def update?
    user.admin? || user.event_organizer? && record.event_organizer == user.event_organizer
  end

  def destroy?
    record.bookings.empty? && (user.admin? || user.event_organizer? && record.event_organizer == user.event_organizer)
  end
end
