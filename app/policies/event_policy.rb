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

  def update? # TODO: add if started dont edit OR if has booking dont edit
    user.event_organizer? && record.event_organizer == user.event_organizer
  end

  def destroy? # TODO: - if has booking dont delete
    user.admin? || user.event_organizer? && record.event_organizer == user.event_organizer
  end
end
