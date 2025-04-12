# frozen_string_literal: true

# app/services/booking_service.rb
class BookingService
  def initialize(booking, event)
    @booking = booking
    @event = event
  end

  def process_and_save!
    return false unless tickets_belong_to_event?
    return false unless tickets_available?

    set_ticket_prices_and_status
    @booking.save
  end

  private

  def tickets_belong_to_event?
    ticket_ids = @booking.booking_tickets.map(&:ticket_id)
    valid = Ticket.where(id: ticket_ids).pluck(:event_id).uniq == [@event.id]
    @booking.errors.add(:base, 'All tickets must belong to the selected event') unless valid
    valid
  end

  def tickets_available?
    tickets = load_tickets
    return false unless validate_ticket_existence(tickets)

    @booking.booking_tickets.each do |bt|
      ticket = tickets[bt.ticket_id]
      if bt.quantity > ticket.quantity
        @booking.errors.add(:base, "Not enough tickets available for ticket ##{bt.ticket_id}")
        return false
      end
    end
    true
  end

  def load_tickets
    ticket_ids = @booking.booking_tickets.map(&:ticket_id)
    Ticket.where(id: ticket_ids).index_by(&:id)
  end

  def validate_ticket_existence(tickets)
    missing_ids = @booking.booking_tickets.map(&:ticket_id) - tickets.keys
    return true if missing_ids.empty?

    @booking.errors.add(:base, "Tickets not found for IDs: #{missing_ids.join(', ')}")
    false
  end

  def set_ticket_prices_and_status
    @booking.total_price = calculate_total_price
    @booking.status = determine_booking_status
  end

  def calculate_total_price
    tickets = Ticket.where(id: @booking.booking_tickets.map(&:ticket_id)).index_by(&:id)
    @booking.booking_tickets.sum do |bt|
      ticket = tickets[bt.ticket_id]
      bt.price = ticket.price
      ticket.price * bt.quantity
    end
  end

  def determine_booking_status
    tickets = Ticket.where(id: @booking.booking_tickets.map(&:ticket_id)).index_by(&:id)
    if @booking.booking_tickets.all? do |bt|
      ticket = tickets[bt.ticket_id]
      ticket.quantity >= bt.quantity
    end
      'confirmed'
    else
      'pending'
    end
  end
end
