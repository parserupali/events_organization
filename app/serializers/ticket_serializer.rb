# frozen_string_literal: true

class TicketSerializer < ActiveModel::Serializer
  attributes :id, :event_title, :ticket_type, :price, :quantity, :created_at, :updated_at

  def event_title
    object.event.title
  end
end
