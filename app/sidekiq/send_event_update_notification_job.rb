# frozen_string_literal: true

# Job to send notifications to customers when an event is updated
class SendEventUpdateNotificationJob
  include Sidekiq::Job

  def perform(event_id)
    event = Event.find(event_id)

    bookings = event.bookings.includes(:customer)

    bookings.each do |booking|
      puts "Notification email will be sent to #{booking.customer.user.email} about the update for Event ##{event.id}"

      # EventMailer.with(event: event, customer: booking.customer).update_notification.deliver_later
    end
  end
end
