# frozen_string_literal: true

class SendTicketConfirmationJob
  include Sidekiq::Job

  def perform(booking_id)
    booking = Booking.find(booking_id)

    puts "Email confirmation will be sent to #{booking.customer.user.email} for Booking ##{booking.id}"

    # BookingMailer.with(booking: booking).confirmation_email.deliver_later
  end
end
