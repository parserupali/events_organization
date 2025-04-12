class EventOrganizerPolicy < ApplicationPolicy
  def index?
    admin? || user.event_organizer?
  end

  def show?
    admin? || user.event_organizer? || user.customer?
  end

  def update?
    admin? || user.event_organizer? && record == user.event_organizer
  end

  def destroy?
    record.events.empty? && (admin? || user.event_organizer? && record == user.event_organizer)
  end
end

