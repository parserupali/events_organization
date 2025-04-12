# frozen_string_literal: true

module Api
  module V1
    class BookingsController < ApplicationController
      before_action :set_booking, only: %i[show]
      before_action :set_event, only: %i[create]

      # GET /events/:event_id/bookings
      def index
        @bookings = Booking.all

        render json: @bookings
      end

      # GET /events/:event_id/bookings/:id
      def show
        render json: @booking
      end

      # POST /events/:event_id/bookings
      def create
        booking = current_user.customer.bookings.build(booking_params.merge(event: @event))
        service = BookingService.new(booking, @event)

        if service.process_and_save!
          SendTicketConfirmationJob.perform_async(booking.id)

          render json: booking, status: :created
        else
          render json: { errors: booking.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_booking
        @booking = Booking.find(params[:id])
      end

      def set_event
        @event = Event.find(params[:event_id])
      end

      # Only allow a list of trusted parameters through.
      def booking_params
        params.require(:booking).permit(:event_id, :status, booking_tickets_attributes: %i[ticket_id quantity])
      end
    end
  end
end
