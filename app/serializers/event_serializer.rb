class EventSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :event_date, :venue, :event_organizer_id, :event_organizer_name, :tickets, :created_at, :updated_at

  def event_organizer_name
    object.event_organizer.user.full_name
  end

  def tickets
    object.tickets.map do |ticket|
      {
        id: ticket.id,
        ticket_type: ticket.ticket_type,
        price: ticket.price,
        quantity: ticket.quantity
      }
    end
  end
end
